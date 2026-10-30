import QtQuick
import Quickshell

// Mini dashboard for the cpu/memory/disk/temperature group
IslandView {
    id: root
    mode: "stats"
    preferredWidth: 420
    preferredHeight: column.implicitHeight + Theme.islandPadding * 2

    Column {
        id: column
        anchors { left: parent.left; right: parent.right; top: parent.top; margins: Theme.islandPadding }
        spacing: 10

        IslandSlider {
            width: parent.width
            interactive: false
            icon: Icons.cpu
            accent: Theme.blue
            value: SysInfo.cpu / 100
            label: `${SysInfo.cpu}%`
        }

        IslandSlider {
            width: parent.width
            interactive: false
            icon: Icons.memory
            accent: Theme.mauve
            value: SysInfo.memory / 100
            label: `${SysInfo.memory}%`
        }

        IslandSlider {
            width: parent.width
            interactive: false
            icon: Icons.disk
            accent: Theme.peach
            value: SysInfo.diskUsed / 100
            label: SysInfo.diskFree
            labelWidth: 70
        }

        IslandSlider {
            width: parent.width
            interactive: false
            icon: Icons.level(Icons.temperature, SysInfo.temperature / 100)
            accent: SysInfo.temperatureCritical ? Theme.red : Theme.flamingo
            value: SysInfo.temperature / 100
            label: `${SysInfo.temperature}°C`
        }

        GlassButton {
            width: parent.width
            height: 36
            radius: 12
            label: "Abrir btop"
            onClicked: {
                ShellState.close();
                Quickshell.execDetached(["kitty", "--start-as=fullscreen", "--title", "all_is_kitty", "sh", "-c", "btop"]);
            }
        }
    }
}
