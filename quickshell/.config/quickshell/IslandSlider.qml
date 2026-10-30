import QtQuick

// Control-center style slider: round glass icon button + glass track + value.
// With interactive: false it doubles as a read-only meter (stats, OSD).
Item {
    id: root

    property real value: 0 // 0..1
    property string icon: ""
    property string label: ""
    property color accent: Theme.mauve
    property bool interactive: true
    property bool dimmed: false
    property int labelWidth: 46

    signal moved(real value)
    signal iconClicked()

    implicitHeight: 40

    GlassButton {
        id: iconButton
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        width: root.height; height: root.height
        radius: height / 2
        icon: root.icon
        iconSize: 16
        iconColor: root.dimmed ? Theme.overlay1 : root.accent
        onClicked: root.iconClicked()
    }

    GlassSurface {
        id: track
        anchors {
            left: iconButton.right; leftMargin: 10
            right: valueText.left; rightMargin: 10
            verticalCenter: parent.verticalCenter
        }
        height: 10
        radius: height / 2
        tint: Theme.glassCard
        sheen: false

        Rectangle {
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: Math.max(parent.height, parent.width * Math.max(0, Math.min(1, root.value)))
            radius: parent.radius
            color: root.accent
            opacity: root.dimmed ? 0.35 : 0.9
            Behavior on width { enabled: !drag.pressed; NumberAnimation { duration: 160; easing.type: Easing.OutCubic } }
        }

        MouseArea {
            id: drag
            anchors.fill: parent
            anchors.topMargin: -12; anchors.bottomMargin: -12
            enabled: root.interactive
            cursorShape: root.interactive ? Qt.PointingHandCursor : Qt.ArrowCursor
            function emit(x) { root.moved(Math.max(0, Math.min(1, x / width))); }
            onPressed: mouse => emit(mouse.x)
            onPositionChanged: mouse => { if (pressed) emit(mouse.x); }
        }
    }

    Text {
        id: valueText
        anchors { right: parent.right; verticalCenter: parent.verticalCenter }
        width: root.labelWidth
        horizontalAlignment: Text.AlignRight
        text: root.label
        color: Theme.subtext1
        font.family: Theme.font
        font.pixelSize: Theme.fontSize - 1
        elide: Text.ElideRight
    }
}
