import QtQuick
import Quickshell

IslandView {
    id: root
    mode: "launcher"
    preferredWidth: Theme.launcherWidth
    preferredHeight: list.preferredHeight

    onOpened: list.reset()

    // Prefix matches on the name rank first, then substring on the name,
    // then generic name / keywords.
    function search(query) {
        const q = query.trim().toLowerCase();
        const scored = [];
        for (const app of DesktopEntries.applications.values) {
            if (app.noDisplay) continue;
            const name = app.name.toLowerCase();
            let score = -1;
            if (!q) score = 3;
            else if (name.startsWith(q)) score = 0;
            else if (name.includes(q)) score = 1;
            else if (app.genericName.toLowerCase().includes(q)
                     || app.keywords.some(k => k.toLowerCase().includes(q))) score = 2;
            if (score >= 0) scored.push({ app, score });
        }
        scored.sort((a, b) => a.score - b.score || a.app.name.localeCompare(b.app.name));
        return scored.map(s => s.app);
    }

    SearchList {
        id: list
        anchors.fill: parent
        placeholder: "Buscar aplicación…"
        results: root.current ? root.search(query) : []
        textFor: app => app.name
        iconFor: app => Quickshell.iconPath(app.icon, "application-x-executable")

        onActivated: app => {
            app.execute();
            ShellState.close();
        }
    }
}
