import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets

// Screen share picker (OBS, Discord, browsers...). Driven by
// scripts/share-picker, which XDPH runs as its custom_picker_binary; the
// answer goes back through a FIFO the script is blocked reading.
IslandView {
    id: root
    mode: "share"
    preferredWidth: 600
    preferredHeight: 380

    property string fifo: ""
    property bool allowToken: false

    // "Recordar esta selección" is a user preference: persist it, since XDPH
    // only passes --allow-token when allow_token_by_default is set.
    FileView {
        id: rememberPref
        path: Quickshell.statePath("share-remember")
        blockLoading: true
        printErrors: false // missing until the first toggle
    }

    function setAllowToken(value) {
        allowToken = value;
        rememberPref.setText(value ? "1" : "0");
    }
    property string tab: "screen"
    property var windows: []
    // slurp needs the island out of the way without cancelling the request
    property bool selectingRegion: false

    // XDPH list: "handle[HC>]class[HT>]title[HE>]hyprAddress[HA>]" per window
    function begin(list, fifoPath, allow) {
        windows = list.split("[HA>]").filter(e => e.length > 0).map(e => {
            const [handle, rest1] = e.split("[HC>]");
            const [cls, rest2] = (rest1 ?? "").split("[HT>]");
            const [title, address] = (rest2 ?? "").split("[HE>]");
            return { handle, cls, title, address: Number(address).toString(16) };
        });
        fifo = fifoPath;
        rememberPref.reload();
        allowToken = allow || rememberPref.text().trim() === "1";
        tab = "screen";
        selectingRegion = false;
        ShellState.islandMode = "share";
    }

    function respond(answer) {
        if (!fifo) return;
        Quickshell.execDetached(["sh", "-c", 'printf "%s\\n" "$1" > "$2"', "sh", answer, fifo]);
        fifo = "";
    }

    function pick(selection) {
        respond(`${allowToken ? "r" : ""}/${selection}`);
        ShellState.close();
    }

    // Closing the island any other way (Esc, click outside) cancels
    onCurrentChanged: if (!current && fifo && !selectingRegion) respond("")

    function toplevelFor(win) {
        return Hyprland.toplevels.values.find(t => t.address === win.address)?.wayland ?? null;
    }

    Process {
        id: slurp
        command: ["slurp", "-f", "%o %x %y %w %h"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.selectingRegion = false;
                const [out, x, y, w, h] = text.trim().split(" ");
                const screen = Quickshell.screens.find(s => s.name === out);
                if (!screen || !w) { root.respond(""); return; }
                // XDPH expects coordinates relative to the output
                root.respond(`${root.allowToken ? "r" : ""}/region:${out}@${x - screen.x},${y - screen.y},${w},${h}`);
            }
        }
    }

    Column {
        anchors { fill: parent; margins: Theme.islandPadding }
        spacing: 12

        // Header + segmented tabs
        Item {
            width: parent.width
            height: 36

            Column {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                Text {
                    text: "Compartir pantalla"
                    color: Theme.text
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize + 2
                    font.bold: true
                }
                Text {
                    text: "Elegí qué querés compartir"
                    color: Theme.subtext0
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 2
                }
            }

            Row {
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                spacing: 6
                Repeater {
                    model: [{ id: "screen", label: "Pantalla" }, { id: "window", label: "Ventana" }, { id: "region", label: "Región" }]
                    delegate: GlassButton {
                        required property var modelData
                        width: 84; height: 30; radius: 15
                        label: modelData.label
                        active: root.tab === modelData.id
                        onClicked: root.tab = modelData.id
                    }
                }
            }
        }

        // Content
        Item {
            width: parent.width
            height: parent.height - 36 - 44 - 24

            // Screens: live previews
            Row {
                visible: root.tab === "screen"
                anchors.centerIn: parent
                spacing: 12

                Repeater {
                    model: Quickshell.screens
                    delegate: PreviewCard {
                        required property var modelData
                        width: 260; height: 180
                        source: root.current && root.tab === "screen" ? modelData : null
                        title: modelData.name
                        subtitle: `${modelData.width}×${modelData.height}`
                        onClicked: root.pick(`screen:${modelData.name}`)
                    }
                }
            }

            // Windows: live previews when the toplevel can be matched
            GridView {
                visible: root.tab === "window"
                anchors.fill: parent
                clip: true
                cellWidth: Math.floor(width / 3)
                cellHeight: 150
                boundsBehavior: Flickable.StopAtBounds
                model: root.windows

                delegate: Item {
                    required property var modelData
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    PreviewCard {
                        anchors { fill: parent; margins: 5 }
                        source: root.current && root.tab === "window" ? root.toplevelFor(modelData) : null
                        appIcon: Quickshell.iconPath(DesktopEntries.heuristicLookup(modelData.cls)?.icon ?? modelData.cls, "application-x-executable")
                        title: modelData.title || modelData.cls
                        subtitle: modelData.cls
                        onClicked: root.pick(`window:${modelData.handle}`)
                    }
                }
            }

            // Region: hand over to slurp
            GlassButton {
                visible: root.tab === "region"
                anchors.centerIn: parent
                width: 260; height: 110; radius: 20
                icon: Icons.crop
                iconSize: 30
                iconColor: Theme.mauve
                label: "Seleccionar región con el mouse"
                onClicked: {
                    root.selectingRegion = true;
                    ShellState.close();
                    slurp.running = true;
                }
            }
        }

        // Footer
        Item {
            width: parent.width
            height: 44

            Row {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                spacing: 10
                GlassSwitch {
                    anchors.verticalCenter: parent.verticalCenter
                    checked: root.allowToken
                    onToggled: root.setAllowToken(!root.allowToken)
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Recordar esta selección"
                    color: Theme.subtext1
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 1
                }
            }

            GlassButton {
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                width: 96; height: 32; radius: 12
                label: "Cancelar"
                onClicked: ShellState.close()
            }
        }
    }

    // Live capture thumbnail with caption; falls back to an icon
    component PreviewCard: GlassButton {
        id: card
        property var source: null
        property string title: ""
        property string subtitle: ""
        property string appIcon: ""

        radius: 16

        ClippingRectangle {
            id: preview
            anchors { left: parent.left; right: parent.right; top: parent.top; margins: 8 }
            height: parent.height - 52
            radius: 10
            color: Theme.glassCard

            ScreencopyView {
                id: capture
                anchors.fill: parent
                visible: hasContent
                captureSource: card.source
                live: true
            }

            IconImage {
                anchors.centerIn: parent
                visible: card.appIcon !== "" && !capture.hasContent
                implicitSize: 40
                source: card.appIcon
            }
        }

        Column {
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom; margins: 10 }
            Text {
                width: parent.width
                text: card.title
                color: Theme.text
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 1
                elide: Text.ElideRight
            }
            Text {
                width: parent.width
                text: card.subtitle
                color: Theme.overlay1
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 3
                elide: Text.ElideRight
            }
        }
    }
}
