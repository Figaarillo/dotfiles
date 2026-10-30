import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import Quickshell.Widgets

// Tray icons; their menus open inside the island in glass style.
Row {
    id: root

    // These applets keep running (nm-applet is the Wi-Fi password agent,
    // blueman the pairing agent) but their icons are replaced by the bar's
    // network and bluetooth modules, which open island views instead.
    readonly property var hiddenIds: ["nm-applet", "blueman"]

    spacing: 8
    height: Theme.barHeight

    Repeater {
        model: SystemTray.items.values.filter(i => !root.hiddenIds.includes(i.id))

        delegate: IconImage {
            id: trayIcon
            required property var modelData

            anchors.verticalCenter: parent.verticalCenter
            implicitSize: 15
            source: modelData.icon

            // Left click: Activate, falling back to the menu when the item
            // doesn't handle it (AppIndicator apps like Spotify or Steam,
            // whose "show window" lives in the menu)
            Process {
                id: activator
                command: [`${Quickshell.shellDir}/scripts/tray-activate`, trayIcon.modelData.id]
                onExited: code => {
                    if (code !== 0 && trayIcon.modelData.hasMenu) ShellState.openTrayMenu(trayIcon.modelData);
                }
            }

            MouseArea {
                anchors.fill: parent
                anchors.margins: -4
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                cursorShape: Qt.PointingHandCursor
                onClicked: mouse => {
                    const item = trayIcon.modelData;
                    if (mouse.button === Qt.LeftButton) {
                        if (item.onlyMenu && item.hasMenu) ShellState.openTrayMenu(item);
                        else activator.running = true;
                    } else if (mouse.button === Qt.RightButton) {
                        if (item.hasMenu) ShellState.openTrayMenu(item);
                    } else {
                        item.secondaryActivate();
                    }
                }
                onWheel: wheel => trayIcon.modelData.scroll(wheel.angleDelta.y, false)
            }
        }
    }
}
