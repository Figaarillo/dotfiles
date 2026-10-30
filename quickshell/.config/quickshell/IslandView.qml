import QtQuick

// Base for everything the island can show. A view only declares its mode and
// size; the island animates to that size and crossfades between views.
// Views keep a fixed size (anchored top-center) so their layout never reflows
// while the pill morphs around them.
Item {
    id: root

    property string mode
    property int preferredWidth: 400
    property int preferredHeight: 200

    readonly property bool current: ShellState.islandMode === mode

    // Emitted every time the view becomes current (focus inputs, refresh data)
    signal opened()

    width: preferredWidth
    height: preferredHeight

    opacity: current ? 1 : 0
    scale: current ? 1 : 0.94
    visible: opacity > 0
    enabled: current

    Behavior on opacity { NumberAnimation { duration: root.current ? 260 : 120; easing.type: Easing.OutCubic } }
    Behavior on scale { NumberAnimation { duration: 320; easing.type: Easing.OutBack } }
}
