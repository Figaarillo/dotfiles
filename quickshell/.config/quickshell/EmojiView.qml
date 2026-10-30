import QtQuick
import Quickshell
import Quickshell.Io

// Emoji picker in the island (SUPER+.). Pastes the pick straight into the
// focused window once the island lets go of the keyboard.
IslandView {
    id: root
    mode: "emoji"
    solid: true // opens over whatever you're typing in, usually text

    readonly property int columns: 8
    readonly property int cell: 40
    readonly property int maxRecent: 16

    preferredWidth: columns * cell + 24
    preferredHeight: 48 + 6 * cell + 12

    property var all: []      // [{ e, text }] from data/emojis.txt
    property var recent: []   // most recent first
    property int selected: 0
    property string pending: ""

    readonly property var results: {
        const q = input.text.trim().toLowerCase();
        if (!q) {
            const rec = recent.map(e => all.find(x => x.e === e)).filter(x => x);
            return rec.concat(all.filter(x => !recent.includes(x.e)));
        }
        const words = q.split(/\s+/);
        return all.filter(x => words.every(w => x.text.includes(w)));
    }
    onResultsChanged: selected = 0

    onOpened: {
        recentFile.reload();
        recent = recentFile.text().split("\n").filter(e => e);
        input.text = "";
        selected = 0;
        input.forceActiveFocus();
    }

    FileView {
        path: `${Quickshell.shellDir}/data/emojis.txt`
        onLoaded: root.all = text().split("\n").filter(l => l).map(l => {
            const i = l.indexOf(" ");
            return { e: l.slice(0, i), text: l.slice(i + 1).toLowerCase() };
        })
    }

    FileView {
        id: recentFile
        path: Quickshell.statePath("emoji-recent")
        blockLoading: true
        printErrors: false
    }

    function pick(emoji) {
        recent = [emoji].concat(recent.filter(e => e !== emoji)).slice(0, maxRecent);
        recentFile.setText(recent.join("\n"));
        pending = emoji;
        ShellState.close();
        // Let the compositor give focus back to the app before pasting
        pasteTimer.restart();
    }

    Timer {
        id: pasteTimer
        interval: 120
        onTriggered: {
            // Terminals paste with Ctrl+Shift+V, everything else with Ctrl+V.
            // The emoji is passed as an argument, never interpolated.
            Quickshell.execDetached(["sh", "-c", `
                wl-copy -- "$1" || exit 1
                case "$(hyprctl activewindow -j | jq -r .class)" in
                    kitty|Alacritty|foot|footclient|org.wezfurlong.wezterm|com.mitchellh.ghostty) mods="CTRL SHIFT" ;;
                    *) mods="CTRL" ;;
                esac
                sleep 0.05
                hyprctl dispatch "hl.dsp.send_shortcut({ mods = '$mods', key = 'V' })" >/dev/null`,
                "sh", root.pending]);
        }
    }

    Item {
        id: inputBox
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: 48

        Text {
            id: promptGlyph
            anchors { left: parent.left; leftMargin: 18; verticalCenter: parent.verticalCenter }
            text: Icons.search
            color: Theme.mauve
            font.family: Theme.font
            font.pixelSize: Theme.fontSize + 2
        }

        TextInput {
            id: input
            anchors { left: promptGlyph.right; leftMargin: 10; right: parent.right; rightMargin: 18; verticalCenter: parent.verticalCenter }
            color: Theme.text
            font.family: Theme.font
            font.pixelSize: Theme.fontSize + 1
            clip: true

            Keys.onPressed: event => {
                const n = root.results.length;
                switch (event.key) {
                case Qt.Key_Escape: ShellState.close(); break;
                case Qt.Key_Right: root.selected = Math.min(root.selected + 1, n - 1); break;
                case Qt.Key_Left: root.selected = Math.max(root.selected - 1, 0); break;
                case Qt.Key_Down: root.selected = Math.min(root.selected + root.columns, n - 1); break;
                case Qt.Key_Up: root.selected = Math.max(root.selected - root.columns, 0); break;
                case Qt.Key_Return:
                case Qt.Key_Enter: if (root.results[root.selected]) root.pick(root.results[root.selected].e); break;
                default: return;
                }
                event.accepted = true;
            }

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                visible: !input.text
                text: "Buscar emoji…"
                color: Theme.overlay0
                font: input.font
            }
        }
    }

    GridView {
        anchors { top: inputBox.bottom; left: parent.left; right: parent.right; bottom: parent.bottom; leftMargin: 12; rightMargin: 12; bottomMargin: 12 }
        clip: true
        cellWidth: root.cell
        cellHeight: root.cell
        boundsBehavior: Flickable.StopAtBounds
        model: root.current ? root.results : []
        currentIndex: root.selected
        highlightMoveDuration: 0
        onCurrentIndexChanged: positionViewAtIndex(currentIndex, GridView.Contain)

        delegate: Rectangle {
            required property var modelData
            required property int index

            width: root.cell; height: root.cell
            radius: 10
            color: index === root.selected ? Theme.glassCardHover : "transparent"

            Text {
                anchors.centerIn: parent
                text: modelData.e
                font.pixelSize: 22
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: root.selected = index
                onClicked: root.pick(modelData.e)
            }
        }
    }
}
