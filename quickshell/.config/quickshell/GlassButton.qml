import QtQuick

// Glass card button: glyph + optional caption, with hover/press feedback.
GlassSurface {
    id: root

    property string icon: ""
    property string label: ""
    property color iconColor: Theme.text
    property int iconSize: 20
    property bool active: false
    property color activeTint: Theme.glassCardActive

    signal clicked()

    radius: 14
    tint: active ? activeTint : area.containsMouse ? Theme.glassCardHover : Theme.glassCard
    rim: Theme.glassBorder

    scale: area.pressed ? 0.94 : 1
    Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutBack } }

    Column {
        anchors.centerIn: parent
        spacing: 4

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: root.icon !== ""
            text: root.icon
            color: root.iconColor
            font.family: Theme.font
            font.pixelSize: root.iconSize
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: root.label !== ""
            text: root.label
            color: Theme.subtext1
            font.family: Theme.font
            font.pixelSize: Theme.fontSize - 2
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
