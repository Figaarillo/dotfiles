import QtQuick

// Transient feedback when volume, mic or brightness change from anywhere
// (keys, scroll, other apps). Auto-closes; never takes focus.
IslandView {
    id: root
    mode: "osd"
    // Same height as the bar: the OSD never spills out of the bar row
    preferredWidth: 260
    preferredHeight: Theme.collapsedHeight

    readonly property string kind: ShellState.osdKind
    readonly property bool isLayout: kind === "layout"

    readonly property string icon: isLayout ? Icons.keyboard
        : kind === "brightness" ? Icons.level(Icons.backlight, SysInfo.brightness)
        : kind === "mic" ? (Audio.isMuted(Audio.source) ? Icons.micMuted : Icons.mic)
        : Audio.sinkIcon()
    readonly property real value: kind === "brightness" ? SysInfo.brightness
        : kind === "mic" ? (Audio.source?.audio?.volume ?? 0)
        : (Audio.sink?.audio?.volume ?? 0)
    readonly property bool muted: kind === "mic" ? Audio.isMuted(Audio.source)
        : kind === "volume" ? Audio.isMuted(Audio.sink) : false
    readonly property color accent: isLayout ? Theme.lavender : kind === "brightness" ? Theme.teal : Theme.mauve

    Text {
        id: glyph
        anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
        text: root.icon
        color: root.muted ? Theme.overlay1 : root.accent
        font.family: Theme.font
        font.pixelSize: 14
    }

    Text {
        visible: root.isLayout
        anchors { left: glyph.right; leftMargin: 12; right: percent.left; rightMargin: 12; verticalCenter: parent.verticalCenter }
        text: Keyboard.keymap
        color: Theme.text
        font.family: Theme.font
        font.pixelSize: Theme.fontSize - 1
        elide: Text.ElideRight
    }

    GlassSurface {
        visible: !root.isLayout
        anchors {
            left: glyph.right; leftMargin: 12
            right: percent.left; rightMargin: 12
            verticalCenter: parent.verticalCenter
        }
        height: 5
        radius: 2.5
        tint: Theme.glassCard
        sheen: false

        Rectangle {
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: parent.width * Math.max(0, Math.min(1, root.value))
            radius: parent.radius
            color: root.accent
            opacity: root.muted ? 0.35 : 1
            Behavior on width { NumberAnimation { duration: 140; easing.type: Easing.OutCubic } }
        }
    }

    Text {
        id: percent
        anchors { right: parent.right; rightMargin: 14; verticalCenter: parent.verticalCenter }
        text: root.isLayout ? Keyboard.label : root.muted ? "Mute" : `${Math.round(root.value * 100)}%`
        color: Theme.subtext1
        font.family: Theme.font
        font.pixelSize: Theme.fontSize - 1
    }
}
