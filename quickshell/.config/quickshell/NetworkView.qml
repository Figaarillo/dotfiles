import QtQuick
import Quickshell
import Quickshell.Networking

// Wi-Fi panel: toggle, nearby networks, connect/disconnect, password prompt.
IslandView {
    id: root
    mode: "network"
    preferredWidth: 420
    preferredHeight: column.implicitHeight + Theme.islandPadding * 2

    readonly property var device: Networking.devices.values.find(d => d.type === DeviceType.Wifi) ?? null
    readonly property var networks: device
        ? device.networks.values.slice()
            .sort((a, b) => (b.connected - a.connected) || (b.signalStrength - a.signalStrength))
            .slice(0, 7)
        : []
    readonly property var connected: networks.find(n => n.connected) ?? null

    // Network waiting for a password
    property var pending: null

    // Only scan while the panel is open
    onCurrentChanged: if (device) device.scannerEnabled = current
    onOpened: pending = null

    Column {
        id: column
        anchors { left: parent.left; right: parent.right; top: parent.top; margins: Theme.islandPadding }
        spacing: 6

        // Header: title + current network + toggle
        Item {
            width: parent.width
            height: 40

            Column {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                Text {
                    text: "Wi-Fi"
                    color: Theme.text
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize + 2
                    font.bold: true
                }
                Text {
                    text: !Networking.wifiEnabled ? "Apagado"
                        : root.connected ? root.connected.name : "Sin conexión"
                    color: Theme.subtext0
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 2
                }
            }

            GlassSwitch {
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                checked: Networking.wifiEnabled
                onToggled: Networking.wifiEnabled = !Networking.wifiEnabled
            }
        }

        Repeater {
            model: Networking.wifiEnabled ? root.networks : []

            delegate: GlassSurface {
                id: netRow
                required property var modelData

                width: column.width
                height: 38
                radius: 12
                sheen: false
                tint: modelData.connected ? Theme.glassCardActive : netArea.containsMouse ? Theme.glassCardHover : "transparent"
                rim: modelData.connected ? Theme.glassBorder : "transparent"

                Text {
                    id: strength
                    anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                    text: Icons.level(Icons.wifi, netRow.modelData.signalStrength)
                    color: Theme.blue
                    font.family: Theme.font
                    font.pixelSize: 16
                }

                Text {
                    anchors { left: strength.right; leftMargin: 12; right: status.left; rightMargin: 8; verticalCenter: parent.verticalCenter }
                    text: netRow.modelData.name
                    color: netRow.modelData.connected ? Theme.text : Theme.subtext0
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 1
                    elide: Text.ElideRight
                }

                Text {
                    id: status
                    anchors { right: parent.right; rightMargin: 12; verticalCenter: parent.verticalCenter }
                    text: netRow.modelData.stateChanging ? "Conectando…"
                        : netRow.modelData.connected ? Icons.check
                        : netRow.modelData.known ? "Guardada" : ""
                    color: netRow.modelData.connected ? Theme.mauve : Theme.overlay1
                    font.family: Theme.font
                    font.pixelSize: netRow.modelData.connected ? 16 : Theme.fontSize - 2
                }

                MouseArea {
                    id: netArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        const n = netRow.modelData;
                        if (n.connected) n.disconnect();
                        else if (n.known) n.connect();
                        else { root.pending = n; password.text = ""; password.forceActiveFocus(); }
                    }
                }
            }
        }

        // Password prompt for unknown networks
        GlassSurface {
            visible: !!root.pending
            width: parent.width
            height: 40
            radius: 12
            tint: Theme.glassCard

            Text {
                id: lockGlyph
                anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                text: Icons.lock
                color: Theme.mauve
                font.family: Theme.font
                font.pixelSize: 15
            }

            TextInput {
                id: password
                anchors { left: lockGlyph.right; leftMargin: 10; right: parent.right; rightMargin: 12; verticalCenter: parent.verticalCenter }
                echoMode: TextInput.Password
                color: Theme.text
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
                clip: true

                Keys.onReturnPressed: {
                    root.pending.connectWithPsk(text);
                    root.pending = null;
                }
                Keys.onEscapePressed: root.pending = null

                Text {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    visible: !password.text
                    text: root.pending ? `Contraseña para ${root.pending.name}` : ""
                    color: Theme.overlay0
                    font: password.font
                }
            }
        }

        // Hidden networks, VPN, ethernet... stay in the full editor
        GlassButton {
            width: 130; height: 32; radius: 12
            label: "Más opciones"
            onClicked: {
                ShellState.close();
                Quickshell.execDetached(["nm-connection-editor"]);
            }
        }
    }
}
