import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

// The island is its own layer surface anchored only to the top edge, so the
// compositor centers it on screen. It shares no layout with the bar, which is
// why side modules can never push it: only its size changes, symmetrically.
// Bar groups read its live width from ShellState and dodge it.
PanelWindow {
    id: window

    anchors.top: true
    margins.top: Theme.barMargin

    // The surface is sized for the largest view; the mask keeps the
    // transparent area click-through.
    implicitWidth: Theme.islandMaxWidth + 20
    implicitHeight: Theme.islandMaxHeight + 20
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    mask: Region { item: pill }

    // Overlay keeps the island above the DismissLayer (which lives on Top)
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-island"
    // Exclusive so typing works right after SUPER, no click needed.
    // (HyprlandFocusGrab can't be combined with Exclusive: it clears instantly.
    // Click-outside is handled by DismissLayer instead.)
    WlrLayershell.keyboardFocus: ShellState.interactive ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    // ---- view registry: adding a view = one file + one entry here ----
    readonly property var views: [media, player, launcher, clipboard, controls, network, bluetooth, traymenu, notifications, notification, calendar, power, wallpaper, stats, share, emoji, osd]
    readonly property var activeView: views.find(v => v.current) ?? media

    Connections {
        target: ShellState
        function onIslandModeChanged() {
            if (!ShellState.interactive) return;
            // Focus the scope first so Esc works; views may then focus an input
            Qt.callLater(() => {
                scope.forceActiveFocus();
                window.activeView.opened();
            });
        }
    }

    IpcHandler {
        target: "island"

        function toggle(mode: string): void { ShellState.toggle(mode); }
        function toggleLauncher(): void { ShellState.toggle("launcher"); }
        function closeAll(): void { ShellState.close(); }
        // Called by scripts/share-picker (XDPH custom_picker_binary)
        function pickShare(windows: string, fifo: string, allowToken: bool): void {
            share.begin(windows, fifo, allowToken);
        }
        function osd(kind: string): void {
            if (kind === "brightness") SysInfo.refreshBacklight();
            ShellState.osd(kind);
        }
    }

    GlassSurface {
        id: pill

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: window.activeView.preferredWidth
        height: window.activeView.preferredHeight
        radius: ShellState.expanded ? Math.min(26, height / 2) : height / 2

        tint: window.activeView.solid ? Theme.islandSolid : Theme.islandBg
        rim: Theme.islandBorder
        clip: true

        // Published every animation frame so the bar groups dodge in sync
        onWidthChanged: ShellState.islandWidth = width
        Component.onCompleted: ShellState.islandWidth = width

        Behavior on width { NumberAnimation { duration: Theme.morphDuration; easing.type: Easing.OutBack; easing.overshoot: 1.1 } }
        Behavior on height { NumberAnimation { duration: Theme.morphDuration; easing.type: Easing.OutBack; easing.overshoot: 1.1 } }
        Behavior on radius { NumberAnimation { duration: Theme.morphDuration; easing.type: Easing.OutCubic } }

        FocusScope {
            id: scope
            anchors.fill: parent
            Keys.onEscapePressed: ShellState.close()

            // Views keep their own fixed size, anchored top-center: the pill
            // clips them while it morphs, so nothing reflows mid-animation.
            MediaView { id: media; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            PlayerView { id: player; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            LauncherView { id: launcher; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            ClipboardView { id: clipboard; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            ControlsView { id: controls; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            NetworkView { id: network; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            BluetoothView { id: bluetooth; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            TrayMenuView { id: traymenu; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            NotificationsView { id: notifications; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            NotificationToastView { id: notification; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            CalendarView { id: calendar; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            PowerView { id: power; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            WallpaperView { id: wallpaper; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            StatsView { id: stats; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            ShareView { id: share; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            EmojiView { id: emoji; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
            OsdView { id: osd; anchors { top: parent.top; horizontalCenter: parent.horizontalCenter } }
        }
    }
}
