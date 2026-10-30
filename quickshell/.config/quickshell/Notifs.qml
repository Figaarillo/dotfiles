pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

// Notification server (replaces swaync). Keeps the history the center view
// lists, and drives the island toast for incoming notifications.
Singleton {
    id: root

    // Persisted so do-not-disturb survives reloads and logins
    property bool dnd: false
    onDndChanged: if (dndLoaded) dndFile.setText(dnd ? "1" : "0")
    property bool dndLoaded: false

    FileView {
        id: dndFile
        path: Quickshell.statePath("notifications-dnd")
        blockLoading: true
        printErrors: false // missing until the first toggle
    }
    // Newest first. Entries wrap the notification with its arrival time,
    // since the spec has no timestamp.
    property var items: []
    readonly property int count: items.length

    // Entry the toast is showing
    property var popup: null
    property bool popupHeld: false

    IpcHandler {
        target: "notifications"
        function toggleDnd(): void { root.dnd = !root.dnd; }
        function isDnd(): bool { return root.dnd; }
    }

    NotificationServer {
        id: server
        keepOnReload: true
        persistenceSupported: true
        actionsSupported: true
        imageSupported: true
        bodyMarkupSupported: true
        onNotification: n => root.add(n)
    }

    // After a config reload the server keeps its notifications; rebuild the list
    Component.onCompleted: {
        dndFile.reload();
        dnd = dndFile.text().trim() === "1";
        dndLoaded = true;
        for (const n of server.trackedNotifications.values) track(n, Date.now());
        items = server.trackedNotifications.values.map(n => ({ n, time: Date.now() }));
    }

    function track(n, time) {
        n.closed.connect(() => root.remove(n));
    }

    function add(n) {
        n.tracked = true;
        track(n);
        const entry = { n, time: Date.now() };
        // replaces_id reuses the same id: update in place instead of duplicating
        items = [entry].concat(items.filter(e => e.n.id !== n.id));
        if (!dnd || n.urgency === NotificationUrgency.Critical) showPopup(entry);
    }

    function remove(n) {
        items = items.filter(e => e.n !== n);
        // Already closed: end the toast without trying to close it again
        if (popup?.n === n) endPopup(false);
    }

    function dismiss(n) { n.dismiss(); }

    function clearAll() {
        for (const e of items.slice()) e.n.dismiss();
        items = [];
    }

    // Clicking a notification = its "default" action, like most daemons.
    // invoke() already closes non-resident notifications (and resident ones
    // must stay), so only dismiss when there's no action to run.
    function activate(n) {
        const action = n.actions.find(a => a.identifier === "default");
        if (action) action.invoke();
        else n.dismiss();
        ShellState.close();
    }

    // Bare absolute paths would resolve against qrc:/ in QML
    function asUrl(path) {
        return path.startsWith("/") ? `file://${path}` : path;
    }

    function iconFor(n) {
        if (n.image) return asUrl(n.image);
        if (n.appIcon) {
            if (n.appIcon.startsWith("/") || n.appIcon.startsWith("file://")) return asUrl(n.appIcon);
            const path = Quickshell.iconPath(n.appIcon, true);
            if (path) return path;
        }
        const entry = DesktopEntries.heuristicLookup(n.desktopEntry || n.appName);
        return entry ? Quickshell.iconPath(entry.icon, true) : "";
    }

    function ago(time, now) {
        const minutes = Math.floor((now - time) / 60000);
        if (minutes < 1) return "ahora";
        if (minutes < 60) return `hace ${minutes} min`;
        const hours = Math.floor(minutes / 60);
        if (hours < 24) return `hace ${hours} h`;
        return Theme.locale.toString(new Date(time), "d MMM");
    }

    // ---------- toast ----------
    function showPopup(entry) {
        // Never interrupt a view the user opened on purpose; the bell dot shows it
        if (ShellState.interactive) return;
        popup = entry;
        ShellState.islandMode = "notification";
        popupTimer.interval = entry.n.urgency === NotificationUrgency.Critical ? 10000
            : entry.n.expireTimeout > 0 ? Math.max(3000, Math.min(entry.n.expireTimeout, 10000))
            : 5000;
        popupTimer.restart();
    }

    function endPopup(expireTransient = true) {
        const entry = popup;
        popup = null;
        popupTimer.stop();
        if (ShellState.islandMode === "notification") ShellState.close();
        // Transient notifications don't belong in the history
        if (expireTransient && entry?.n?.transient) entry.n.expire();
    }

    // Hovering the toast keeps it open
    onPopupHeldChanged: popupHeld ? popupTimer.stop() : (popup && popupTimer.restart())

    Timer { id: popupTimer; onTriggered: root.endPopup() }
}
