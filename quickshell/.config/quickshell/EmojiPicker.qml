import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

// Emoji picker that opens next to the mouse pointer (Wayland doesn't expose
// another app's text caret, but the pointer is usually where you clicked to
// type) and pastes the pick straight into the focused window.
PanelWindow {
    id: root

    property bool open: false
    property var all: []      // [{ e, text }] from data/emojis.txt
    property var recent: []   // most recent first
    property int selected: 0
    property point at: Qt.point(0, 0)

    readonly property int columns: 8
    readonly property int cell: 40
    readonly property int maxRecent: 16

    visible: open
    anchors { top: true; bottom: true; left: true; right: true }
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-emoji"
    WlrLayershell.keyboardFocus: open ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

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

    IpcHandler {
        target: "emoji"
        function toggle(): void { root.open ? root.close() : cursor.running = true; }
    }

    // Where to open: the pointer position, read right before showing
    Process {
        id: cursor
        command: ["hyprctl", "cursorpos", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                const p = JSON.parse(text);
                root.at = Qt.point(p.x, p.y);
                root.show();
            }
        }
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

    function show() {
        recentFile.reload();
        recent = recentFile.text().split("\n").filter(e => e);
        input.text = "";
        selected = 0;
        open = true;
        input.forceActiveFocus();
    }

    function close() {
        open = false;
    }

    function pick(emoji) {
        recent = [emoji].concat(recent.filter(e => e !== emoji)).slice(0, maxRecent);
        recentFile.setText(recent.join("\n"));
        close();
        pending = emoji;
        // Let the compositor give focus back to the app before pasting
        pasteTimer.restart();
    }

    property string pending: ""
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

    // Click anywhere outside the card closes it
    MouseArea {
        anchors.fill: parent
        onPressed: root.close()
    }

    GlassSurface {
        id: card

        width: root.columns * root.cell + 24
        height: 52 + 6 * root.cell + 16
        radius: 22
        // Always solid: it opens over whatever you're typing in, often text
        tint: Theme.islandSolid
        rim: Theme.islandBorder

        // Next to the pointer, flipped above it near the bottom edge
        x: Math.max(8, Math.min(root.at.x - 24, root.width - width - 8))
        y: root.at.y + 16 + height < root.height - 8 ? root.at.y + 16 : Math.max(8, root.at.y - height - 16)

        scale: root.open ? 1 : 0.9
        opacity: root.open ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 260; easing.type: Easing.OutBack } }
        Behavior on opacity { NumberAnimation { duration: 140 } }

        // Swallow clicks so they don't reach the dismiss area
        MouseArea { anchors.fill: parent }

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
                    case Qt.Key_Escape: root.close(); break;
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
            id: grid
            anchors { top: inputBox.bottom; left: parent.left; right: parent.right; bottom: parent.bottom; leftMargin: 12; rightMargin: 12; bottomMargin: 12 }
            clip: true
            cellWidth: root.cell
            cellHeight: root.cell
            boundsBehavior: Flickable.StopAtBounds
            model: root.results
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
}
