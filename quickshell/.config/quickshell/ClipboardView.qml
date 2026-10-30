import QtQuick
import Quickshell
import Quickshell.Io

// cliphist history, same actions as ~/.config/scripts/clipboard:
// Enter copies the entry, Supr deletes it.
IslandView {
    id: root
    mode: "clipboard"
    preferredWidth: Theme.launcherWidth
    preferredHeight: list.preferredHeight

    property var entries: []

    onOpened: {
        list.reset();
        cliphist.running = true;
    }

    // cliphist lines are "<id>\t<preview>"; the whole line is what decode/delete expect
    function preview(line) {
        return line.slice(line.indexOf("\t") + 1).trim();
    }

    Process {
        id: cliphist
        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: root.entries = text.split("\n").filter(l => l.length > 0)
        }
    }

    Timer { id: reload; interval: 150; onTriggered: cliphist.running = true }

    SearchList {
        id: list
        anchors.fill: parent
        placeholder: "Portapapeles · Supr borra"
        promptIcon: Icons.clipboard
        results: {
            const q = query.trim().toLowerCase();
            return q ? root.entries.filter(l => root.preview(l).toLowerCase().includes(q)) : root.entries;
        }
        textFor: line => root.preview(line)
        glyphFor: line => Icons.clipboardText

        // The entry goes as an argument, never interpolated into the script
        onActivated: line => {
            Quickshell.execDetached(["sh", "-c", 'printf "%s" "$1" | cliphist decode | wl-copy', "sh", line]);
            ShellState.close();
        }
        onDeleteRequested: line => {
            Quickshell.execDetached(["sh", "-c", 'printf "%s" "$1" | cliphist delete', "sh", line]);
            reload.restart();
        }
    }
}
