import QtQuick

// iOS-style toggle on glass
GlassSurface {
    id: root

    property bool checked: false
    signal toggled()

    width: 48; height: 26
    radius: 13
    sheen: false
    tint: checked ? Qt.rgba(137 / 255, 180 / 255, 250 / 255, 0.55) : Theme.glassCard

    Rectangle {
        width: 20; height: 20; radius: 10
        anchors.verticalCenter: parent.verticalCenter
        x: root.checked ? parent.width - width - 3 : 3
        color: Theme.text
        Behavior on x { NumberAnimation { duration: 260; easing.type: Easing.OutBack } }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled()
    }
}
