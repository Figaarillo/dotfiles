pragma Singleton
import QtQuick
import Quickshell

// State shared between the bar and the island. The island owns its mode and
// publishes its live (animated) width so bar groups can dodge it frame by frame.
Singleton {
    id: root

    // "media" is the resting pill; any other value is an expanded IslandView.
    // "osd" and "notification" are transient: they auto-close and never take
    // the keyboard, so they can't steal typing from another window.
    property string islandMode: "media"
    property string osdKind: ""
    readonly property bool expanded: islandMode !== "media"
    readonly property bool interactive: expanded && islandMode !== "osd" && islandMode !== "notification"

    property real islandWidth: 0
    // Free half-width between the bar's side groups (published by Bar)
    property real centerRoom: 0

    property bool barVisible: true
    property var barWindow: null

    // Tray item whose menu the island is showing ("traymenu" view)
    property var trayItem: null

    function openTrayMenu(item) {
        trayItem = item;
        islandMode = "traymenu";
    }

    function toggle(mode) {
        islandMode = islandMode === mode ? "media" : mode;
    }

    function close() {
        islandMode = "media";
    }

    // Transient feedback (volume, brightness...). Never interrupts a view the
    // user opened on purpose.
    function osd(kind) {
        if (interactive) return;
        osdKind = kind;
        islandMode = "osd";
        osdTimer.restart();
    }

    Timer {
        id: osdTimer
        interval: Theme.osdDuration
        onTriggered: if (root.islandMode === "osd") root.close()
    }
}
