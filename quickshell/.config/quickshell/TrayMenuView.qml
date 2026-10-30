import QtQuick
import Quickshell
import Quickshell.Widgets

// Renders a tray app's DBus menu inside the island, in the same glass style,
// instead of the toolkit's native popup. Submenus push onto a stack.
IslandView {
    id: root
    mode: "traymenu"
    preferredWidth: 320
    preferredHeight: Math.min(Theme.islandMaxHeight, header.height + list.contentHeight + Theme.islandPadding * 2)

    readonly property var item: ShellState.trayItem
    // Stack of submenu entries; empty = root menu
    property var stack: []
    readonly property var currentMenu: stack.length ? stack[stack.length - 1] : item?.menu ?? null

    onOpened: stack = []

    // DBus menus mark mnemonics with "_" (and some Qt apps with "&")
    function clean(text) {
        return (text ?? "").replace(/_(?!_)/g, "").replace(/&(?!&)/g, "");
    }

    function activate(entry) {
        if (!entry.enabled || entry.isSeparator) return;
        if (entry.hasChildren) {
            stack = stack.concat([entry]);
            return;
        }
        entry.triggered();
        ShellState.close();
    }

    QsMenuOpener {
        id: opener
        menu: root.currentMenu
    }

    Item {
        id: header
        anchors { top: parent.top; left: parent.left; right: parent.right; margins: Theme.islandPadding }
        height: 30

        GlassButton {
            id: back
            visible: root.stack.length > 0
            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
            width: 28; height: 28; radius: 14
            icon: Icons.chevronLeft
            iconSize: 14
            onClicked: root.stack = root.stack.slice(0, -1)
        }

        Text {
            anchors { left: back.visible ? back.right : parent.left; leftMargin: back.visible ? 10 : 4; right: parent.right; verticalCenter: parent.verticalCenter }
            text: root.stack.length ? root.clean(root.stack[root.stack.length - 1].text)
                : root.item?.tooltipTitle || root.item?.title || root.item?.id || ""
            color: Theme.text
            font.family: Theme.font
            font.pixelSize: Theme.fontSize + 1
            font.bold: true
            elide: Text.ElideRight
        }
    }

    ListView {
        id: list
        anchors {
            top: header.bottom; topMargin: 8
            left: parent.left; right: parent.right; bottom: parent.bottom
            leftMargin: Theme.islandPadding - 6; rightMargin: Theme.islandPadding - 6; bottomMargin: Theme.islandPadding - 6
        }
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        model: opener.children

        delegate: Item {
            id: entryRow
            required property var modelData
            readonly property var e: modelData

            width: ListView.view.width
            // Entries can be destroyed under us (menu refresh, reload)
            height: e?.isSeparator ? 9 : 34

            Rectangle {
                visible: entryRow.e?.isSeparator
                anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter; leftMargin: 10; rightMargin: 10 }
                height: 1
                color: Theme.glassBorder
            }

            Rectangle {
                visible: !entryRow.e?.isSeparator
                anchors.fill: parent
                radius: 10
                color: entryArea.containsMouse && entryRow.e?.enabled ? Theme.glassCardHover : "transparent"
                opacity: entryRow.e?.enabled ? 1 : 0.4

                Text {
                    id: checkMark
                    anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                    width: 16
                    visible: entryRow.e?.buttonType !== QsMenuButtonType.None
                    text: entryRow.e?.checkState === Qt.Checked ? Icons.check : ""
                    color: Theme.mauve
                    font.family: Theme.font
                    font.pixelSize: 14
                }

                IconImage {
                    id: entryIcon
                    anchors { left: checkMark.visible ? checkMark.right : parent.left; leftMargin: checkMark.visible ? 6 : 10; verticalCenter: parent.verticalCenter }
                    implicitSize: 16
                    visible: entryRow.e?.icon !== ""
                    source: entryRow.e?.icon
                }

                Text {
                    anchors {
                        left: entryIcon.visible ? entryIcon.right : checkMark.visible ? checkMark.right : parent.left
                        leftMargin: entryIcon.visible || checkMark.visible ? 10 : 12
                        right: chevron.left; rightMargin: 8
                        verticalCenter: parent.verticalCenter
                    }
                    text: root.clean(entryRow.e?.text)
                    color: Theme.text
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 1
                    elide: Text.ElideRight
                }

                Text {
                    id: chevron
                    anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
                    text: entryRow.e?.hasChildren ? Icons.chevronRight : ""
                    color: Theme.overlay1
                    font.family: Theme.font
                    font.pixelSize: 14
                }

                MouseArea {
                    id: entryArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: entryRow.e?.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: root.activate(entryRow.e)
                }
            }
        }
    }
}
