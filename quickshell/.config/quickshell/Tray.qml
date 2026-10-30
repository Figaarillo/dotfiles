import QtQuick
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

            MouseArea {
                anchors.fill: parent
                anchors.margins: -4
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                cursorShape: Qt.PointingHandCursor
                onClicked: mouse => {
                    const item = trayIcon.modelData;
                    if (mouse.button === Qt.LeftButton) {
                        if (item.onlyMenu && item.hasMenu) ShellState.openTrayMenu(item);
                        else item.activate();
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
