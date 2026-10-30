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

    onOpened: armed = ""

    readonly property var items: [
        { action: "lock", label: "Bloquear", icon: Icons.lock, color: Theme.blue, confirm: false },
        { action: "suspend", label: "Suspender", icon: Icons.sleep, color: Theme.mauve, confirm: false },
        { action: "hibernate", label: "Hibernar", icon: Icons.hibernate, color: Theme.teal, confirm: false },
        { action: "logout", label: "Salir", icon: Icons.logout, color: Theme.peach, confirm: true },
        { action: "reboot", label: "Reiniciar", icon: Icons.reboot, color: Theme.flamingo, confirm: true },
        { action: "shutdown", label: "Apagar", icon: Icons.shutdown, color: Theme.red, confirm: true },
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

    Row {
        id: actions
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: root.items

            delegate: GlassButton {
                required property var modelData
                readonly property bool isArmed: root.armed === modelData.action

                width: 72; height: 86
                radius: 18
                icon: modelData.icon
                iconSize: 24
                iconColor: modelData.color
                label: isArmed ? "¿Seguro?" : modelData.label
                active: isArmed
                activeTint: Qt.rgba(243 / 255, 139 / 255, 168 / 255, 0.28)
                onClicked: root.run(modelData)
            }
        }
    }
}
