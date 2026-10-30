import QtQuick
import Quickshell.Services.Pipewire

// Control center: output, mic and brightness sliders + output device picker.
// Opened from the volume, mic and brightness items of the bar.
IslandView {
    id: root
    mode: "controls"
    preferredWidth: 420
    preferredHeight: column.implicitHeight + Theme.islandPadding * 2

    Column {
        id: column
        anchors { fill: parent; margins: Theme.islandPadding }
        spacing: 10

        IslandSlider {
            width: parent.width
            icon: Audio.sinkIcon()
            value: Audio.sink?.audio?.volume ?? 0
            label: Audio.isMuted(Audio.sink) ? "Mute" : `${Audio.percent(Audio.sink)}%`
            dimmed: Audio.isMuted(Audio.sink)
            onMoved: v => Audio.setVolume(Audio.sink, v)
            onIconClicked: Audio.toggleMute(Audio.sink)
        }

        IslandSlider {
            width: parent.width
            icon: Audio.isMuted(Audio.source) ? Icons.micMuted : Icons.mic
            value: Audio.source?.audio?.volume ?? 0
            label: Audio.isMuted(Audio.source) ? "Mute" : `${Audio.percent(Audio.source)}%`
            dimmed: Audio.isMuted(Audio.source)
            onMoved: v => Audio.setVolume(Audio.source, v)
            onIconClicked: Audio.toggleMute(Audio.source)
        }

        IslandSlider {
            width: parent.width
            icon: Icons.level(Icons.backlight, SysInfo.brightness)
            accent: Theme.teal
            value: SysInfo.brightness
            label: `${Math.round(SysInfo.brightness * 100)}%`
            onMoved: v => SysInfo.setBrightness(v)
        }

        Text {
            visible: Audio.sinks.length > 1
            topPadding: 4
            text: "Salida"
            color: Theme.overlay1
            font.family: Theme.font
            font.pixelSize: Theme.fontSize - 2
        }

        Repeater {
            model: Audio.sinks.length > 1 ? Audio.sinks : []

            delegate: GlassSurface {
                id: sinkRow
                required property var modelData
                readonly property bool isDefault: modelData === Audio.sink

                width: column.width
                height: 34
                radius: 12
                sheen: false
                tint: isDefault ? Theme.glassCardActive : sinkArea.containsMouse ? Theme.glassCardHover : "transparent"
                rim: isDefault ? Theme.glassBorder : "transparent"

                Text {
                    anchors { left: parent.left; leftMargin: 12; right: check.left; rightMargin: 8; verticalCenter: parent.verticalCenter }
                    text: Audio.nodeName(sinkRow.modelData)
                    color: sinkRow.isDefault ? Theme.text : Theme.subtext0
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 1
                    elide: Text.ElideRight
                }

                Text {
                    id: check
                    anchors { right: parent.right; rightMargin: 12; verticalCenter: parent.verticalCenter }
                    visible: sinkRow.isDefault
                    text: Icons.check
                    color: Theme.mauve
                    font.family: Theme.font
                    font.pixelSize: 16
                }

                MouseArea {
                    id: sinkArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Pipewire.preferredDefaultAudioSink = sinkRow.modelData
                }
            }
        }
    }
}
