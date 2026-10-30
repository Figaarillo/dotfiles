import QtQuick

// One glass pill in the bar. Knows on which side of the island it lives and
// fades/slides outward when the island grows into it (the dynamic-island dodge).
GlassSurface {
    id: root

    default property alias content: row.data
    property int padding: Theme.groupPadding
    property alias spacing: row.spacing
    property bool hoverable: false

    // Parent is the side Row, a direct child of the bar content item, whose
    // center is the screen center (the bar has symmetric margins).
    readonly property real barX: parent ? parent.x + x : 0
    readonly property real barCenter: parent && parent.parent ? parent.parent.width / 2 : 0
    readonly property string side: barX + width / 2 < barCenter ? "left" : "right"

    // Live island bounds: the island publishes its animated width
    readonly property real islandLeft: barCenter - ShellState.islandWidth / 2 - Theme.islandGap
    readonly property real islandRight: barCenter + ShellState.islandWidth / 2 + Theme.islandGap
    readonly property bool dodging: barX < islandRight && barX + width > islandLeft

    implicitWidth: row.implicitWidth + padding * 2
    implicitHeight: Theme.barHeight
    radius: height / 2

    tint: hoverable && hover.hovered ? Theme.glassHover : Theme.glass

    opacity: dodging ? 0 : 1
    enabled: !dodging
    Behavior on opacity { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }

    transform: Translate {
        x: root.dodging ? (root.side === "left" ? -16 : 16) : 0
        Behavior on x { NumberAnimation { duration: 320; easing.type: Easing.OutBack } }
    }

    HoverHandler { id: hover }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 12
    }
}
