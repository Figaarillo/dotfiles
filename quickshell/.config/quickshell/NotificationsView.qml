import QtQuick
import Quickshell

// Notification center: history, do-not-disturb and clear all.
IslandView {
    id: root
    mode: "notifications"
    preferredWidth: 440
    preferredHeight: Math.min(Theme.islandMaxHeight,
        header.height + Theme.islandPadding * 2 + 8 + (Notifs.count ? list.contentHeight : empty.height))

    SystemClock { id: clock; precision: SystemClock.Minutes }

    Item {
        id: header
        anchors { left: parent.left; right: parent.right; top: parent.top; margins: Theme.islandPadding }
        height: 36

        Column {
            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
            Text {
                text: "Notificaciones"
                color: Theme.text
                font.family: Theme.font
                font.pixelSize: Theme.fontSize + 2
                font.bold: true
            }
            Text {
                text: Notifs.dnd ? "No molestar activado" : Notifs.count ? `${Notifs.count} sin leer` : "Al día"
                color: Theme.subtext0
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 2
            }
        }

        Row {
            anchors { right: parent.right; verticalCenter: parent.verticalCenter }
            spacing: 10

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Icons.bellDnd
                color: Notifs.dnd ? Theme.mauve : Theme.overlay1
                font.family: Theme.font
                font.pixelSize: 15
            }

            GlassSwitch {
                anchors.verticalCenter: parent.verticalCenter
                checked: Notifs.dnd
                onToggled: Notifs.dnd = !Notifs.dnd
            }

            GlassButton {
                anchors.verticalCenter: parent.verticalCenter
                visible: Notifs.count > 0
                width: 72; height: 28; radius: 10
                label: "Borrar"
                onClicked: Notifs.clearAll()
            }
        }
    }

    Text {
        id: empty
        visible: Notifs.count === 0
        anchors { horizontalCenter: parent.horizontalCenter; top: header.bottom; topMargin: 8 }
        height: 60
        verticalAlignment: Text.AlignVCenter
        text: "Sin notificaciones"
        color: Theme.overlay1
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
    }

    ListView {
        id: list
        anchors {
            top: header.bottom; topMargin: 8
            left: parent.left; right: parent.right; bottom: parent.bottom
            leftMargin: Theme.islandPadding; rightMargin: Theme.islandPadding; bottomMargin: Theme.islandPadding
        }
        clip: true
        spacing: 8
        boundsBehavior: Flickable.StopAtBounds
        model: Notifs.items

        // Cards slide out when dismissed
        remove: Transition { NumberAnimation { properties: "opacity"; to: 0; duration: 160 } }
        displaced: Transition { NumberAnimation { properties: "y"; duration: 220; easing.type: Easing.OutCubic } }

        delegate: NotificationCard {
            required property var modelData
            width: ListView.view.width
            entry: modelData
            now: clock.date.getTime()
        }
    }
}
