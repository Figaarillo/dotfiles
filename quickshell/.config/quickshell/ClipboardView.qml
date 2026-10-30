import QtQuick
import Quickshell
import Quickshell.Io

// cliphist history: Enter copies the entry, Supr deletes it. Images show a
// thumbnail decoded once by scripts/clip-list into the shell cache.
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

    readonly property string thumbDir: `${Quickshell.cacheDir}/clipboard`

    // cliphist lines are "<id>\t<preview>"; the whole line is what decode/delete expect
    function preview(line) {
        return line.slice(line.indexOf("\t") + 1).trim();
    }

    // "[[ binary data 85 KiB png 614x441 ]]" -> { size, ext, dims }
    function imageInfo(line) {
        const m = preview(line).match(/^\[\[ binary data (.+) (png|jpeg|jpg|webp|gif|bmp) (\d+x\d+) \]\]$/);
        return m ? { size: m[1], ext: m[2], dims: m[3].replace("x", "×") } : null;
    }

    function thumbPath(line) {
        const info = imageInfo(line);
        return info ? `${thumbDir}/${line.slice(0, line.indexOf("\t"))}.${info.ext}` : "";
    }

    function label(line) {
        const info = imageInfo(line);
        return info ? `Imagen ${info.ext.toUpperCase()} · ${info.dims} · ${info.size}` : preview(line);
    }

    Process {
        id: cliphist
        command: [`${Quickshell.shellDir}/scripts/clip-list`, root.thumbDir]
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
            return q ? root.entries.filter(l => root.label(l).toLowerCase().includes(q)) : root.entries;
        }
        textFor: line => root.label(line)
        thumbFor: line => root.thumbPath(line)
        rowHeightFor: line => root.imageInfo(line) ? 64 : Theme.launcherRowHeight
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
