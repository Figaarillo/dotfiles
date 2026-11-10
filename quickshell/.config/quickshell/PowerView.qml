import QtQuick
import Quickshell

// Session actions (scripts/power). Logout/reboot/shutdown need a second click to
// confirm, so a stray click never kills the session.
IslandView {
    id: root
    mode: "power"
    preferredWidth: actions.implicitWidth + Theme.islandPadding * 2
    preferredHeight: 118

    property string armed: ""
    property int selected: 0

    onOpened: {
        armed = "";
        selected = 0;
        keys.forceActiveFocus();
    }

    function select(i) {
        selected = (i + items.length) % items.length;
        armed = ""; // moving away cancels a pending confirmation
    }

    readonly property var items: [
        { action: "lock", label: "Bloquear", key: "b", icon: Icons.lock, color: Theme.blue, confirm: false },
        { action: "suspend", label: "Dormir", key: "d", icon: Icons.sleep, color: Theme.mauve, confirm: false },
        { action: "hibernate", label: "Hibernar", key: "h", icon: Icons.hibernate, color: Theme.teal, confirm: false },
        { action: "logout", label: "Salir", key: "s", icon: Icons.logout, color: Theme.peach, confirm: true },
        { action: "reboot", label: "Reiniciar", key: "r", icon: Icons.reboot, color: Theme.flamingo, confirm: true },
        { action: "shutdown", label: "Apagar", key: "a", icon: Icons.shutdown, color: Theme.red, confirm: true },
    ]

    function run(item) {
        if (item.confirm && armed !== item.action) {
            armed = item.action;
            disarm.restart();
            return;
        }
        ShellState.close();
        Quickshell.execDetached([`${Quickshell.shellDir}/scripts/power`, item.action]);
    }

    Timer { id: disarm; interval: 3000; onTriggered: root.armed = "" }

    // Initial letter runs its action (pressed twice for confirm items, like a click).
    // Arrows / Tab select and Enter or Space runs the selection.
    // Matches event.text so it follows the active xkb layout.
    // Esc is not accepted here, so it bubbles up to the island scope and closes.
    Item {
        id: keys
        Keys.onPressed: event => {
            const k = event.key;
            const letter = root.items.findIndex(i => i.key === event.text.toLowerCase());
            if (letter >= 0) {
                if (root.selected !== letter) root.select(letter);
                root.run(root.items[letter]);
            }
            else if (k === Qt.Key_Right || k === Qt.Key_Tab) root.select(root.selected + 1);
            else if (k === Qt.Key_Left || k === Qt.Key_Backtab) root.select(root.selected - 1);
            else if (k === Qt.Key_Return || k === Qt.Key_Enter || k === Qt.Key_Space) root.run(root.items[root.selected]);
            else return;
            event.accepted = true;
        }
    }

    Row {
        id: actions
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: root.items

            delegate: GlassButton {
                required property var modelData
                required property int index
                readonly property bool isArmed: root.armed === modelData.action
                readonly property bool isSelected: root.selected === index

                width: 72; height: 86
                radius: 18
                icon: modelData.icon
                iconSize: 24
                iconColor: modelData.color
                // Initial tinted with the action color: it's the shortcut key
                label: isArmed ? "¿Seguro?"
                     : `<font color="${modelData.color}"><b>${modelData.label[0]}</b></font>${modelData.label.slice(1)}`
                active: isArmed || isSelected
                activeTint: isArmed ? Qt.rgba(243 / 255, 139 / 255, 168 / 255, 0.28) : Theme.glassCardActive
                rim: isSelected ? modelData.color : Theme.glassBorder
                onClicked: {
                    if (root.selected !== index) root.select(index);
                    root.run(modelData);
                }
            }
        }
    }
}
