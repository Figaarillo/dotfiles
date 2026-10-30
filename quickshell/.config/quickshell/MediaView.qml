import QtQuick

// Resting pill. Click expands the player; middle click plays/pauses;
// scroll skips tracks.
IslandView {
    id: root
    mode: "media"

    // Sizes flow one way only (text -> row -> island) to avoid a binding loop.
    // Width follows the content but is clamped, so the island only ever
    // shrinks/grows within a fixed range around the screen center.
    readonly property int padding: 32
    // Capped by the theme and by the real room the bar leaves in the center
    readonly property int maxWidth: ShellState.centerRoom > 0
        ? Math.min(Theme.mediaMaxWidth, Math.floor(ShellState.centerRoom * 2))
        : Theme.mediaMaxWidth
    readonly property int maxLabelWidth: maxWidth - padding - icon.implicitWidth - row.spacing
    preferredWidth: Math.max(Theme.mediaMinWidth, row.implicitWidth + padding)
    preferredHeight: Theme.collapsedHeight

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 8

        Text {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            text: !Media.player ? "󰝛" : Media.player.isPlaying ? "󰏤" : "󰐊"
            color: Theme.mauve
            font.family: Theme.font
            font.pixelSize: Theme.fontSize + 2
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Media.label || "Nada sonando"
            color: Media.label ? Theme.text : Theme.overlay0
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            elide: Text.ElideRight
            width: Math.min(implicitWidth, root.maxLabelWidth)
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.MiddleButton) {
                if (Media.player?.canTogglePlaying) Media.player.togglePlaying();
            } else {
                ShellState.toggle("player");
            }
        }
        onWheel: wheel => {
            if (!Media.player) return;
            if (wheel.angleDelta.y > 0) Media.player.previous();
            else Media.player.next();
        }
    }
}
