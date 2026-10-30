import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets

// Bluetooth panel: power toggle, paired devices (connect/disconnect, battery),
// and a scan mode to pair new ones. blueman-applet keeps running as the
// pairing agent; this only replaces its tray icon and manager window.
IslandView {
    id: root
    mode: "bluetooth"
    preferredWidth: 420
    preferredHeight: column.implicitHeight + Theme.islandPadding * 2

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property bool powered: !!adapter?.enabled
    readonly property var devices: (adapter ? adapter.devices.values : [])
        .filter(d => d.paired || (adapter.discovering && d.name))
        .sort((a, b) => (b.connected - a.connected) || (b.paired - a.paired) || a.name.localeCompare(b.name))
        .slice(0, 7)
    readonly property var connectedNames: devices.filter(d => d.connected).map(d => d.name)

    // Stop scanning when the panel closes, it drains battery
    onCurrentChanged: if (!current && adapter?.discovering) adapter.discovering = false

    function activate(device) {
        if (device.connected) device.disconnect();
        else if (device.paired) device.connect();
        else { device.trusted = true; device.pair(); }
    }

    Column {
        id: column
        anchors { left: parent.left; right: parent.right; top: parent.top; margins: Theme.islandPadding }
        spacing: 6

        Item {
            width: parent.width
            height: 40

            Column {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                Text {
                    text: "Bluetooth"
                    color: Theme.text
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize + 2
                    font.bold: true
                }
                Text {
                    text: !root.powered ? "Apagado"
                        : root.connectedNames.length ? root.connectedNames.join(", ") : "Sin dispositivos conectados"
                    color: Theme.subtext0
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 2
                    elide: Text.ElideRight
                    width: 280
                }
            }

            GlassSwitch {
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                checked: root.powered
                onToggled: if (root.adapter) root.adapter.enabled = !root.adapter.enabled
            }
        }

        Repeater {
            model: root.powered ? root.devices : []

            delegate: GlassSurface {
                id: devRow
                required property var modelData
                readonly property var d: modelData

                width: column.width
                height: 40
                radius: 12
                sheen: false
                tint: d.connected ? Theme.glassCardActive : devArea.containsMouse ? Theme.glassCardHover : "transparent"
                rim: d.connected ? Theme.glassBorder : "transparent"

                IconImage {
                    id: devIcon
                    anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                    implicitSize: 22
                    source: Quickshell.iconPath(devRow.d.icon, "bluetooth")
                }

                Text {
                    anchors { left: devIcon.right; leftMargin: 12; right: status.left; rightMargin: 8; verticalCenter: parent.verticalCenter }
                    text: devRow.d.name
                    color: devRow.d.connected ? Theme.text : Theme.subtext0
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 1
                    elide: Text.ElideRight
                }

                Text {
                    id: status
                    anchors { right: parent.right; rightMargin: 12; verticalCenter: parent.verticalCenter }
                    text: devRow.d.state === BluetoothDeviceState.Connecting ? "Conectando…"
                        : devRow.d.pairing ? "Emparejando…"
                        : devRow.d.connected && devRow.d.batteryAvailable ? `${Icons.battery} ${Math.round(devRow.d.battery * 100)}%`
                        : devRow.d.connected ? Icons.check
                        : devRow.d.paired ? "" : "Emparejar"
                    color: devRow.d.connected ? Theme.mauve : Theme.overlay1
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 2
                }

                MouseArea {
                    id: devArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.activate(devRow.d)
                }
            }
        }

        Row {
            visible: root.powered
            topPadding: 4
            spacing: 8

            GlassButton {
                width: 130; height: 32; radius: 12
                label: root.adapter?.discovering ? "Buscando…" : "Buscar nuevos"
                active: !!root.adapter?.discovering
                onClicked: root.adapter.discovering = !root.adapter.discovering
            }

            GlassButton {
                width: 130; height: 32; radius: 12
                label: "Más opciones"
                onClicked: {
                    ShellState.close();
                    Quickshell.execDetached(["blueman-manager"]);
                }
            }
        }
    }
}
