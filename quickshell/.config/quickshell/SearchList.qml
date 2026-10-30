import QtQuick
import Quickshell
import Quickshell.Widgets

// Search input + keyboard-driven result list, shared by launcher & clipboard.
// The owning view filters; this component only renders and navigates.
Item {
    id: root

    property var results: []
    property int selected: 0
    property string placeholder: ""
    property string promptIcon: Icons.search
    property int maxVisible: Theme.launcherMaxResults

    // Per-item accessors, set by the owning view
    property var textFor: item => String(item)
    property var iconFor: item => ""   // image source; empty falls back to glyph
    property var glyphFor: item => ""

    readonly property alias query: input.text
    readonly property int preferredHeight: Theme.launcherInputHeight
        + (results.length > 0 ? Math.min(results.length, maxVisible) * Theme.launcherRowHeight + 12 : 0)

    signal activated(var item)
    signal deleteRequested(var item)

    onResultsChanged: selected = Math.min(selected, Math.max(0, results.length - 1))

    function reset() {
        input.text = "";
        selected = 0;
        input.forceActiveFocus();
    }

    Item {
        id: inputBox
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: Theme.launcherInputHeight

        Text {
            id: promptGlyph
            anchors { left: parent.left; leftMargin: 20; verticalCenter: parent.verticalCenter }
            text: root.promptIcon
            color: Theme.mauve
            font.family: Theme.font
            font.pixelSize: Theme.fontSize + 3
        }

        TextInput {
            id: input
            anchors {
                left: promptGlyph.right; leftMargin: 12
                right: parent.right; rightMargin: 20
                verticalCenter: parent.verticalCenter
            }
            color: Theme.text
            selectionColor: Theme.surface1
            font.family: Theme.font
            font.pixelSize: Theme.fontSize + 2
            clip: true

            onTextChanged: root.selected = 0

            Keys.onPressed: event => {
                switch (event.key) {
                case Qt.Key_Escape:
                    ShellState.close(); break;
                case Qt.Key_Down:
                case Qt.Key_Tab:
                    root.selected = Math.min(root.selected + 1, root.results.length - 1); break;
                case Qt.Key_Up:
                case Qt.Key_Backtab:
                    root.selected = Math.max(root.selected - 1, 0); break;
                case Qt.Key_Return:
                case Qt.Key_Enter:
                    if (root.results[root.selected]) root.activated(root.results[root.selected]);
                    break;
                case Qt.Key_Delete:
                    if (root.results[root.selected]) root.deleteRequested(root.results[root.selected]);
                    break;
                default:
                    return;
                }
                event.accepted = true;
            }

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                visible: !input.text
                text: root.placeholder
                color: Theme.overlay0
                font: input.font
            }
        }
    }

    ListView {
        id: list
        anchors {
            top: inputBox.bottom
            left: parent.left; right: parent.right
            bottom: parent.bottom
            margins: 6; topMargin: 0
        }
        clip: true
        interactive: false
        model: root.results
        currentIndex: root.selected
        highlightMoveDuration: 0
        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Contain)

        delegate: Rectangle {
            id: row
            required property var modelData
            required property int index
            readonly property bool isSelected: index === root.selected

            width: ListView.view.width
            height: Theme.launcherRowHeight
            radius: 12
            color: isSelected ? Theme.glassCardHover : "transparent"
            border.color: isSelected ? Theme.glassBorder : "transparent"
            Behavior on color { ColorAnimation { duration: 120 } }

            IconImage {
                id: rowIcon
                anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                implicitSize: 24
                visible: source != ""
                source: root.iconFor(row.modelData)
            }

            Text {
                anchors.centerIn: rowIcon
                visible: !rowIcon.visible
                text: root.glyphFor(row.modelData)
                color: Theme.mauve
                font.family: Theme.font
                font.pixelSize: 18
            }

            Text {
                anchors {
                    left: rowIcon.right; leftMargin: 12
                    right: parent.right; rightMargin: 12
                    verticalCenter: parent.verticalCenter
                }
                text: root.textFor(row.modelData)
                color: row.isSelected ? Theme.text : Theme.subtext0
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
                elide: Text.ElideRight
                maximumLineCount: 1
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: root.selected = row.index
                onClicked: root.activated(row.modelData)
            }
        }
    }
}
