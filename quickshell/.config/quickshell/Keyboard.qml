pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

// Active keyboard layout (ALT+Space toggles it via xkb grp:alt_space_toggle).
// Layouts are per keyboard in Hyprland, so this follows the keyboard that
// just switched, remembers the choice and restores it on every keyboard at
// startup (xkb always boots on the first layout).
Singleton {
    id: root

    property string keymap: ""   // e.g. "English (US, intl., with dead keys)"
    property int index: -1
    property int layoutCount: 1
    readonly property string label: keymap.includes("intl") ? "INTL" : "US"

    // Keyboard named by the last activelayout event; main keyboard otherwise
    property string lastKeyboard: ""
    property bool restored: false

    FileView {
        id: saved
        path: Quickshell.statePath("kb-layout")
        blockLoading: true
        printErrors: false // missing until the first switch
    }

    // Explicit index, not "next": "all next" toggles each keyboard on its own
    // and keeps them out of sync if they already disagree
    function next() {
        Quickshell.execDetached(["hyprctl", "switchxkblayout", "all", String((index + 1) % layoutCount)]);
    }

    function refresh() {
        if (devices.running) pending = true;
        else devices.running = true;
    }
    property bool pending: false

    function update(json) {
        const keyboards = JSON.parse(json).keyboards;
        // The event names whichever device switched (even power buttons);
        // fall back to the main keyboard
        const kb = keyboards.find(k => k.name === lastKeyboard)
            ?? keyboards.find(k => k.main)
            ?? keyboards[0];
        if (!kb) return;
        layoutCount = Math.max(1, kb.layout.split(",").length);

        if (!restored) {
            restored = true;
            keymap = kb.active_keymap;
            index = kb.active_layout_index;
            saved.reload();
            const want = parseInt(saved.text());
            if (!isNaN(want)) syncAll(keyboards, want);
            return;
        }

        if (kb.active_layout_index === index) return;
        keymap = kb.active_keymap;
        index = kb.active_layout_index;
        saved.setText(String(index));
        ShellState.osd("layout");
        // ALT+Space only switches the keyboard it was pressed on: mirror the
        // choice to every keyboard so they never disagree
        syncAll(keyboards, index);
    }

    function syncAll(keyboards, target) {
        if (keyboards.some(k => k.active_layout_index !== target))
            Quickshell.execDetached(["hyprctl", "switchxkblayout", "all", String(target)]);
    }

    Process {
        id: devices
        command: ["hyprctl", "devices", "-j"]
        stdout: StdioCollector { onStreamFinished: root.update(text) }
        onRunningChanged: if (!running && root.pending) { root.pending = false; running = true; }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name !== "activelayout") return;
            // data: "<keyboard>,<layout name>"
            root.lastKeyboard = event.data.split(",")[0];
            root.refresh();
        }
    }

    Component.onCompleted: refresh()
}
