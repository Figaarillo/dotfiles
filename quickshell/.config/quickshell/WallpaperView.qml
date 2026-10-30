import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

// Thumbnail picker for ~/Pictures/Wallpapers. Applies through the same
// ~/.config/scripts/wall script and keeps the index in /tmp/current_wall so
// `expand cycle` (SUPER + [ / ]) continues from the picked one.
IslandView {
    id: root
    mode: "wallpaper"
    preferredWidth: 640
    preferredHeight: 400

    readonly property string home: Quickshell.env("HOME")

    onOpened: lastWall.reload()

    FolderListModel {
        id: walls
        folder: `file://${root.home}/Pictures/Wallpapers`
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
        sortField: FolderListModel.Name
    }

    FileView {
        id: lastWall
        path: `${root.home}/.cache/awww_last_wall`
        watchChanges: true
        onFileChanged: reload()
        // text() is a function, not a property, so push the value on load
        onLoaded: root.currentPath = text().trim()
    }
    property string currentPath: ""

    GridView {
        id: grid
        anchors { fill: parent; margins: Theme.islandPadding; rightMargin: Theme.islandPadding - 8 }
        clip: true
        cellWidth: Math.floor(width / 4)
        cellHeight: Math.round(cellWidth * 0.62)
        model: walls
        boundsBehavior: Flickable.StopAtBounds

        delegate: Item {
            id: cell
            required property string filePath
            required property url fileUrl
            required property int index
            readonly property bool isCurrent: filePath === root.currentPath

            width: grid.cellWidth
            height: grid.cellHeight

            ClippingRectangle {
                id: thumb
                anchors { fill: parent; margins: 5 }
                radius: 12
                color: Theme.glassCard
                scale: area.containsMouse ? 1.04 : 1
                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutBack } }

                Image {
                    anchors.fill: parent
                    source: cell.fileUrl
                    sourceSize.width: 300
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                }
            }

            // Selection ring drawn outside the clip
            Rectangle {
                anchors.fill: thumb
                anchors.margins: -2
                scale: thumb.scale
                radius: thumb.radius + 2
                color: "transparent"
                border.width: 2
                border.color: cell.isCurrent ? Theme.mauve : area.containsMouse ? Theme.glassShine : "transparent"
            }

            MouseArea {
                id: area
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(["sh", "-c",
                    'echo "$2" > /tmp/current_wall && "$HOME/.config/scripts/wall" "$1"',
                    "sh", cell.filePath, String(cell.index)])
            }
        }
    }
}
