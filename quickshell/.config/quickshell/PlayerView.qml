import QtQuick
import Quickshell.Widgets

IslandView {
    id: root
    mode: "player"
    preferredWidth: 460
    preferredHeight: 156

    readonly property var player: Media.player
    readonly property real progress: player && player.length > 0 ? player.position / player.length : 0

    // MPRIS doesn't push position updates; poll while visible and playing
    FrameAnimation {
        running: root.current && !!root.player?.isPlaying
        onTriggered: root.player.positionChanged()
    }

    ClippingRectangle {
        id: art
        anchors { left: parent.left; leftMargin: Theme.islandPadding; verticalCenter: parent.verticalCenter }
        width: 124; height: 124
        radius: 18
        color: Theme.glassCard

        Image {
            anchors.fill: parent
            source: root.player?.trackArtUrl ?? ""
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            sourceSize.width: 248
        }

        Text {
            anchors.centerIn: parent
            visible: !root.player?.trackArtUrl
            text: Icons.music
            color: Theme.overlay1
            font.family: Theme.font
            font.pixelSize: 40
        }
    }

    Column {
        anchors {
            left: art.right; leftMargin: 16
            right: parent.right; rightMargin: Theme.islandPadding
            verticalCenter: parent.verticalCenter
        }
        spacing: 6

        Text {
            width: parent.width
            text: root.player?.trackTitle || "Nada sonando"
            color: Theme.text
            font.family: Theme.font
            font.pixelSize: Theme.fontSize + 3
            font.bold: true
            elide: Text.ElideRight
        }

        Text {
            width: parent.width
            text: root.player?.trackArtist || root.player?.identity || ""
            color: Theme.subtext0
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            elide: Text.ElideRight
        }

        // Progress, click to seek
        Item {
            width: parent.width
            height: 22

            GlassSurface {
                id: bar
                anchors { left: parent.left; right: parent.right; top: parent.top; topMargin: 6 }
                height: 6
                radius: 3
                tint: Theme.glassCard
                sheen: false

                Rectangle {
                    anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                    width: parent.width * Math.max(0, Math.min(1, root.progress))
                    radius: parent.radius
                    color: Theme.mauve
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.topMargin: -8; anchors.bottomMargin: -8
                    enabled: !!root.player?.canSeek
                    cursorShape: Qt.PointingHandCursor
                    onClicked: mouse => root.player.position = root.player.length * (mouse.x / width)
                }
            }

            Text {
                anchors { left: parent.left; bottom: parent.bottom }
                text: Media.formatTime(root.player?.position ?? 0)
                color: Theme.overlay1
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 3
            }

            Text {
                anchors { right: parent.right; bottom: parent.bottom }
                text: Media.formatTime(root.player?.length ?? 0)
                color: Theme.overlay1
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 3
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 14

            GlassButton {
                anchors.verticalCenter: parent.verticalCenter
                width: 38; height: 38; radius: 19
                icon: Icons.previous
                iconSize: 18
                enabled: !!root.player?.canGoPrevious
                onClicked: root.player.previous()
            }

            GlassButton {
                anchors.verticalCenter: parent.verticalCenter
                width: 46; height: 46; radius: 23
                icon: root.player?.isPlaying ? Icons.pause : Icons.play
                iconSize: 22
                iconColor: Theme.mauve
                active: true
                enabled: !!root.player?.canTogglePlaying
                onClicked: root.player.togglePlaying()
            }

            GlassButton {
                anchors.verticalCenter: parent.verticalCenter
                width: 38; height: 38; radius: 19
                icon: Icons.next
                iconSize: 18
                enabled: !!root.player?.canGoNext
                onClicked: root.player.next()
            }
        }
    }
}
