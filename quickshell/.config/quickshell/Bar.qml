import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Networking
import Quickshell.Bluetooth

// Left click on a module opens its island view; right click keeps the
// external app waybar used (pavucontrol, nm-connection-editor, btop...).
PanelWindow {
    id: bar

    anchors { top: true; left: true; right: true }
    margins { top: Theme.barMargin; left: Theme.barMargin; right: Theme.barMargin }
    implicitHeight: Theme.barHeight
    color: "transparent"
    visible: ShellState.barVisible

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell-bar"

    // The island whitelists the bar in its focus grab, so clicking another
    // module morphs the island straight into that view instead of closing it.
    Component.onCompleted: ShellState.barWindow = bar

    IpcHandler {
        target: "bar"
        function toggle(): void { ShellState.barVisible = !ShellState.barVisible; }
    }

    readonly property string btop: "kitty --start-as=fullscreen --title all_is_kitty sh -c 'btop'"

    // ---------- network ----------
    readonly property var devices: Networking.devices.values
    readonly property var wifiDevice: devices.find(d => d.type === DeviceType.Wifi && d.connected) ?? null
    readonly property var wifiNetwork: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) ?? null : null
    readonly property bool wired: devices.some(d => d.type === DeviceType.Wired && d.connected)

    // ---------- clock ----------
    SystemClock { id: clock; precision: SystemClock.Minutes }

    // Free half-width around the screen center, published so the resting
    // media pill never grows into the side groups (it shrinks instead).
    readonly property real centerRoom: Math.min(width / 2 - (leftRow.x + leftRow.width),
                                                rightRow.x - width / 2) - Theme.islandGap
    onCenterRoomChanged: ShellState.centerRoom = centerRoom

    // =================== LEFT ===================
    Row {
        id: leftRow
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        spacing: Theme.groupSpacing

        BarGroup {
            hoverable: true
            padding: 10
            BarItem {
                icon: Icons.arch
                iconSize: 16
                color: Theme.mauve
                onRight: "pkill fuzzel || ~/.config/scripts/launcher --list-executables-in-path"
                onLeftClicked: ShellState.toggle("launcher")
            }
        }

        BarGroup {
            Workspaces {}
        }

        BarGroup {
            hoverable: true
            BarItem { icon: Icons.cpu; label: `${SysInfo.cpu}%`; color: Theme.blue; onRight: bar.btop; onLeftClicked: ShellState.toggle("stats") }
            BarItem { icon: Icons.memory; label: `${SysInfo.memory}%`; color: Theme.mauve; onRight: bar.btop; onLeftClicked: ShellState.toggle("stats") }
            BarItem { icon: Icons.disk; label: SysInfo.diskFree; color: Theme.peach; onRight: bar.btop; onLeftClicked: ShellState.toggle("stats") }
            BarItem {
                icon: Icons.level(Icons.temperature, SysInfo.temperature / 100)
                label: `${SysInfo.temperature}°C`
                color: SysInfo.temperatureCritical ? Theme.red : Theme.flamingo
                onRight: bar.btop
                onLeftClicked: ShellState.toggle("stats")
            }
        }
    }

    // =================== RIGHT ===================
    Row {
        id: rightRow
        anchors { right: parent.right; verticalCenter: parent.verticalCenter }
        spacing: Theme.groupSpacing

        BarGroup {
            BarItem {
                // Material glyphs are drawn smaller inside their box than the others
                iconSize: Theme.fontSize + 4
                icon: bar.wifiNetwork ? Icons.level(Icons.wifi, bar.wifiNetwork.signalStrength)
                    : bar.wired ? Icons.ethernet : Icons.disconnected
                label: bar.wifiNetwork ? `${Math.round(bar.wifiNetwork.signalStrength * 100)}%`
                    : bar.wired ? "" : "No Internet"
                color: bar.wifiNetwork || bar.wired ? Theme.blue : Theme.overlay1
                onRight: "nm-connection-editor"
                onLeftClicked: ShellState.toggle("network")
            }
            BarItem {
                readonly property var adapter: Bluetooth.defaultAdapter
                readonly property bool anyConnected: !!adapter && adapter.devices.values.some(d => d.connected)
                // The bluetooth glyph is narrow by design; it needs a bit more
                iconSize: Theme.fontSize + 6
                icon: !adapter?.enabled ? Icons.bluetoothOff : anyConnected ? Icons.bluetoothConnected : Icons.bluetooth
                color: adapter?.enabled ? Theme.blue : Theme.overlay1
                onRight: "blueman-manager"
                onLeftClicked: ShellState.toggle("bluetooth")
            }
            BarItem {
                icon: Audio.sinkIcon()
                label: Audio.isMuted(Audio.sink) ? "" : `${Audio.percent(Audio.sink)}%`
                color: Audio.isMuted(Audio.sink) ? Theme.overlay1 : Theme.mauve
                onRight: "pavucontrol -t 3"
                onLeftClicked: ShellState.toggle("controls")
                onScrolled: direction => Audio.step(Audio.sink, direction)
            }
            BarItem {
                icon: Audio.isMuted(Audio.source) ? Icons.micMuted : Icons.mic
                color: Audio.isMuted(Audio.source) ? Theme.overlay1 : Theme.mauve
                onRight: "pavucontrol -t 4"
                onLeftClicked: ShellState.toggle("controls")
                onScrolled: direction => Audio.step(Audio.source, direction)
            }
            BarItem {
                iconSize: Theme.fontSize + 4
                icon: Icons.level(Icons.backlight, SysInfo.brightness)
                label: `${Math.round(SysInfo.brightness * 100)}%`
                color: Theme.teal
                onLeftClicked: ShellState.toggle("controls")
                onScrolled: direction => {
                    SysInfo.setBrightness(SysInfo.brightness + direction * 0.05);
                    ShellState.osd("brightness");
                }
            }
            BarItem {
                icon: Icons.clipboard
                color: Theme.mauve
                onLeftClicked: ShellState.toggle("clipboard")
                onMiddle: "rm -f ~/.cache/cliphist/db"
                onRight: "~/.config/scripts/clipboard delete"
            }
            BarItem {
                icon: Notifs.dnd ? Icons.bellDnd : Icons.bell
                color: Theme.mauve
                onLeftClicked: ShellState.toggle("notifications")
                // Right click toggles do-not-disturb, like swaync's right click did
                onRightClicked: Notifs.dnd = !Notifs.dnd

                Rectangle {
                    visible: Notifs.count > 0
                    anchors { right: parent.right; rightMargin: -3; top: parent.top; topMargin: 7 }
                    width: 6; height: 6; radius: 3
                    color: Theme.red
                }
            }
        }

        BarGroup {
            visible: tray.width > 0
            padding: 10
            Tray { id: tray }
        }

        BarGroup {
            hoverable: true
            BarItem {
                icon: Icons.clock
                label: Qt.formatDateTime(clock.date, "HH:mm")
                bold: true
                onLeftClicked: ShellState.toggle("calendar")
            }
        }

        BarGroup {
            hoverable: true
            BarItem {
                icon: Icons.wallpaper
                iconSize: 15
                color: Theme.pink
                onLeftClicked: ShellState.toggle("wallpaper")
                onRight: "~/.config/scripts/tools/expand cycle"
            }
        }

        BarGroup {
            hoverable: true
            BarItem {
                icon: Icons.power
                iconSize: 15
                color: Theme.red
                onLeftClicked: ShellState.toggle("power")
                onRight: "~/.config/wlogout/launch.sh"
            }
        }
    }
}
