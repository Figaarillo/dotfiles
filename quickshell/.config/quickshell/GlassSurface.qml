import QtQuick

// iOS 26 style liquid glass: translucent tint (Hyprland blurs what's behind),
// a hairline rim, a top specular highlight and a soft vertical sheen.
// Children are drawn above the sheen.
Rectangle {
    id: root

    property color tint: Theme.glass
    property color rim: Theme.glassBorder
    property bool sheen: true

    color: tint
    border.color: rim
    border.width: 1
    Behavior on color { ColorAnimation { duration: 200 } }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        radius: Math.max(0, root.radius - 1)
        visible: root.sheen
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.09) }
            GradientStop { position: 0.45; color: Qt.rgba(1, 1, 1, 0.02) }
            GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.0) }
        }
    }

    Rectangle {
        anchors { top: parent.top; topMargin: 1; horizontalCenter: parent.horizontalCenter }
        width: Math.max(0, parent.width - parent.radius * 2)
        height: 1
        visible: root.sheen
        color: Theme.glassShine
    }
}
