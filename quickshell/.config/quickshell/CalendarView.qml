import QtQuick
import QtQuick.Controls

IslandView {
    id: root
    mode: "calendar"
    preferredWidth: 340
    preferredHeight: 330

    property int month: new Date().getMonth()
    property int year: new Date().getFullYear()

    onOpened: {
        const now = new Date();
        month = now.getMonth();
        year = now.getFullYear();
    }

    function shift(delta) {
        const d = new Date(year, month + delta, 1);
        month = d.getMonth();
        year = d.getFullYear();
    }

    Column {
        anchors { fill: parent; margins: Theme.islandPadding }
        spacing: 10

        Item {
            width: parent.width
            height: 44

            Column {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                Text {
                    text: Theme.locale.toString(new Date(root.year, root.month, 1), "MMMM yyyy")
                    color: Theme.text
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize + 3
                    font.bold: true
                    font.capitalization: Font.Capitalize
                }
                Text {
                    text: Theme.locale.toString(new Date(), "dddd d")
                    color: Theme.subtext0
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize - 2
                    font.capitalization: Font.Capitalize
                }
            }

            Row {
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                spacing: 6
                GlassButton { width: 32; height: 32; radius: 16; icon: Icons.chevronLeft; iconSize: 16; onClicked: root.shift(-1) }
                GlassButton { width: 32; height: 32; radius: 16; icon: Icons.chevronRight; iconSize: 16; onClicked: root.shift(1) }
            }
        }

        DayOfWeekRow {
            width: parent.width
            locale: Theme.locale
            delegate: Text {
                required property string shortName
                text: shortName
                horizontalAlignment: Text.AlignHCenter
                color: Theme.overlay1
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 2
            }
        }

        MonthGrid {
            id: grid
            width: parent.width
            height: 210
            month: root.month
            year: root.year
            locale: Theme.locale

            delegate: Item {
                required property var model

                Rectangle {
                    anchors.centerIn: parent
                    width: 30; height: 30; radius: 15
                    visible: model.today
                    color: Theme.mauve
                }

                Text {
                    anchors.centerIn: parent
                    text: model.day
                    color: model.today ? Theme.crust : Theme.text
                    opacity: model.month === grid.month ? 1 : 0.3
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize
                    font.bold: model.today
                }
            }
        }
    }
}
