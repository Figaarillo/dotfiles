import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets

IslandView {
    id: root
    mode: "player"

    readonly property var player: Media.player
    readonly property real progress: player && player.length > 0 ? player.position / player.length : 0

    // Live view of the window playing the media, e.g. a stream left on
    // another workspace (browsers keep painting it). Frames are pulled at
    // ~24 fps instead of a 60 fps live feed, and only while watching.
    property bool watching: false
    readonly property var window: {
        // Browsers put the video title in the window title. Whitespace is
        // normalized: MPRIS and the window title don't always agree on it.
        const norm = text => text.replace(/\s+/g, " ").trim();
        const title = norm(player?.trackTitle ?? "").slice(0, 30);
        if (!title || player.dbusName.endsWith(".spotify")) return null; // has album art
        return Hyprland.toplevels.values.find(t => norm(t.title).includes(title)) ?? null;
    }
    readonly property bool canWatch: !!window?.wayland
    onCanWatchChanged: if (!canWatch) watching = false

    readonly property int videoWidth: 560 - Theme.islandPadding * 2
    readonly property int videoHeight: {
        const s = live.sourceSize;
        const aspect = live.hasContent && s.width > 0 ? s.height / s.width : 9 / 16;
        return Math.min(300, Math.round(videoWidth * aspect));
    }

    preferredWidth: watching ? 560 : 460
    preferredHeight: watching
        ? Theme.islandPadding * 2 + videoHeight + 12 + info.implicitHeight
        : 156

    function focusWindow() {
        const address = `address:0x${window.address}`;
        Hyprland.dispatch(Hyprland.usingLua
            ? `hl.dsp.focus({ window = '${address}' })`
            : `focuswindow ${address}`);
        ShellState.close();
    }

    // MPRIS doesn't push position updates; poll while visible and playing
    FrameAnimation {
        running: root.current && !!root.player?.isPlaying
        onTriggered: root.player.positionChanged()
    }

    ClippingRectangle {
        id: art
        visible: !root.watching
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

    ClippingRectangle {
        id: video
        visible: root.watching
        anchors { top: parent.top; topMargin: Theme.islandPadding; horizontalCenter: parent.horizontalCenter }
        width: root.videoWidth
        height: root.videoHeight
        radius: 14
        color: Theme.glassCard

        ScreencopyView {
            id: live
            anchors.fill: parent
            live: false
            captureSource: root.watching && root.current ? root.window?.wayland ?? null : null
        }

        Timer {
            interval: 42 // ~24 fps
            repeat: true
            running: root.watching && root.current
            onTriggered: live.captureFrame()
        }

        MouseArea {
            id: videoArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.focusWindow()
        }

        GlassSurface {
            anchors { right: parent.right; bottom: parent.bottom; margins: 8 }
            width: hint.implicitWidth + 20; height: 26; radius: 13
            tint: Theme.islandSolid
            opacity: videoArea.containsMouse ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 150 } }
            Text {
                id: hint
                anchors.centerIn: parent
                text: "Ir a la ventana"
                color: Theme.text
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 2
            }
        }
    }

    Column {
        id: info
        anchors {
            left: root.watching ? parent.left : art.right
            leftMargin: root.watching ? Theme.islandPadding : 16
            right: parent.right; rightMargin: Theme.islandPadding
        }
        // A single y binding instead of swapping top/verticalCenter anchors:
        // swapping them leaves both set for a moment, QML rejects the conflict
        // and the column stays below the (hidden) video when going back.
        y: root.watching ? video.y + video.height + 12 : Math.round((parent.height - height) / 2)
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

            // Watch the playing window live
            GlassButton {
                anchors.verticalCenter: parent.verticalCenter
                visible: root.canWatch
                width: 38; height: 38; radius: 19
                icon: Icons.monitor
                iconSize: 17
                active: root.watching
                onClicked: root.watching = !root.watching
            }
        }
    }
}
