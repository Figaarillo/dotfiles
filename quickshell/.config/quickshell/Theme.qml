pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// Catppuccin Mocha, same palette as waybar/style.css
Singleton {
    id: root

    // Clean mode (SUPER+ALT+Z, ~/.scripts/hyprland_toggle_opacity) turns blur
    // off; glass would be see-through without it, so tints go solid.
    property bool clean: false

    FileView {
        path: "/tmp/hypr_cleanmode"
        printErrors: false
        onLoaded: root.clean = true
        onLoadFailed: root.clean = false
    }

    IpcHandler {
        target: "theme"
        function setClean(value: bool): void { root.clean = value; }
    }

    readonly property color base: "#1e1e2e"
    readonly property color mantle: "#181825"
    readonly property color crust: "#11111b"
    readonly property color text: "#cdd6f4"
    readonly property color subtext0: "#a6adc8"
    readonly property color subtext1: "#bac2de"
    readonly property color surface0: "#313244"
    readonly property color surface1: "#45475a"
    readonly property color overlay0: "#6c7086"
    readonly property color overlay1: "#7f849c"
    readonly property color blue: "#89b4fa"
    readonly property color lavender: "#b4befe"
    readonly property color teal: "#94e2d5"
    readonly property color peach: "#fab387"
    readonly property color red: "#f38ba8"
    readonly property color mauve: "#cba6f7"
    readonly property color pink: "#f5c2e7"
    readonly property color flamingo: "#f2cdcd"

    readonly property color glass: Qt.rgba(30 / 255, 30 / 255, 46 / 255, clean ? 0.97 : 0.50)
    readonly property color glassBorder: Qt.rgba(1, 1, 1, 0.10)
    readonly property color glassHover: Qt.rgba(1, 1, 1, 0.12)
    readonly property color glassShine: Qt.rgba(1, 1, 1, 0.16)

    // Liquid glass: translucent tint + compositor blur + specular sheen.
    // The island is a bit denser than the bar so expanded content stays legible.
    readonly property color islandBg: Qt.rgba(24 / 255, 24 / 255, 37 / 255, clean ? 0.98 : 0.58)
    readonly property color islandBorder: Qt.rgba(1, 1, 1, 0.14)
    // Inner controls (rows, buttons, slider tracks) sitting on the island
    readonly property color glassCard: Qt.rgba(1, 1, 1, 0.06)
    readonly property color glassCardHover: Qt.rgba(1, 1, 1, 0.12)
    readonly property color glassCardActive: Qt.rgba(203 / 255, 166 / 255, 247 / 255, 0.22)

    readonly property string font: "CaskaydiaCove Nerd Font"
    readonly property int fontSize: 13
    // UI language, independent of the system locale (Qt ships its own CLDR data)
    readonly property var locale: Qt.locale("es_AR")

    // Bar geometry (mirrors waybar margins)
    readonly property int barHeight: 30
    readonly property int barMargin: 5
    readonly property int groupSpacing: 8
    readonly property int groupPadding: 12

    // Island geometry
    readonly property int collapsedHeight: barHeight
    readonly property int mediaMinWidth: 120
    // Fixed cap; side groups dodge anyway if the island ever reaches them
    readonly property int mediaMaxWidth: 300
    readonly property int launcherWidth: 560
    readonly property int launcherInputHeight: 48
    readonly property int launcherRowHeight: 42
    readonly property int launcherMaxResults: 8
    // The island surface is sized for the largest view
    readonly property int islandMaxWidth: 660
    readonly property int islandMaxHeight: 460
    readonly property int islandPadding: 16
    readonly property int osdDuration: 1500
    // Minimum gap kept between the island and the side groups
    readonly property int islandGap: 6

    readonly property int morphDuration: 420
}
