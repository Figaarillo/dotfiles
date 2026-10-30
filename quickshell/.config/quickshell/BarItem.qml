import QtQuick
import Quickshell

// Icon + optional label with waybar-style click/scroll actions.
// Commands are shell strings, same as waybar's on-click fields.
Item {
    id: root

    property string icon: ""
    property string label: ""
    property color color: Theme.text
    property int iconSize: Theme.fontSize + 1
    property bool bold: false

    property string onLeft: ""
    property string onRight: ""
    property string onMiddle: ""

    signal leftClicked()
    signal rightClicked()
    signal scrolled(int direction) // +1 up, -1 down

    implicitWidth: content.implicitWidth
    implicitHeight: Theme.barHeight

    function run(cmd) {
        if (cmd) Quickshell.execDetached(["sh", "-c", cmd]);
    }

    Row {
        id: content
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.icon !== ""
            text: root.icon
            color: root.color
            font.family: Theme.font
            font.pixelSize: root.iconSize
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.label !== ""
            text: root.label
            color: root.color
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            font.bold: root.bold
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) { root.leftClicked(); root.run(root.onLeft); }
            else if (mouse.button === Qt.RightButton) { root.rightClicked(); root.run(root.onRight); }
            else root.run(root.onMiddle);
        }
        onWheel: wheel => root.scrolled(wheel.angleDelta.y > 0 ? 1 : -1)
    }
}
