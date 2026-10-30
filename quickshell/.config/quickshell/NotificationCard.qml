import QtQuick
import Quickshell.Widgets
import Quickshell.Services.Notifications

// One notification in glass: icon/image, app + time, summary, body, actions.
// Shared by the island toast and the notification center.
GlassSurface {
    id: root

    required property var entry
    property var now: Date.now()
    property int bodyLines: 2

    readonly property var n: entry.n
    readonly property string icon: Notifs.iconFor(n)
    readonly property bool isPhoto: n.image !== ""
    readonly property var actions: n.actions.filter(a => a.identifier !== "default")

    implicitHeight: content.implicitHeight + 24
    radius: 18
    tint: area.containsMouse ? Theme.glassCardHover : Theme.glassCard
    rim: Theme.glassBorder

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: Notifs.activate(root.n)
    }

    ClippingRectangle {
        id: art
        anchors { left: parent.left; top: parent.top; margins: 12 }
        width: 40; height: 40
        radius: 10
        color: Theme.glassCard

        // Photos (avatars, album art) are cropped to fill; themed icons are
        // drawn with IconImage, which resolves the icon provider properly.
        Image {
            anchors.fill: parent
            visible: root.isPhoto
            source: root.isPhoto ? Notifs.asUrl(root.n.image) : ""
            fillMode: Image.PreserveAspectCrop
            sourceSize: Qt.size(80, 80)
            asynchronous: true
        }

        IconImage {
            anchors.centerIn: parent
            visible: !root.isPhoto && root.icon !== ""
            implicitSize: 28
            source: root.isPhoto ? "" : root.icon
        }

        Text {
            anchors.centerIn: parent
            visible: root.icon === ""
            text: Icons.bell
            color: Theme.mauve
            font.family: Theme.font
            font.pixelSize: 18
        }
    }

    Column {
        id: content
        anchors { left: art.right; leftMargin: 12; right: close.left; rightMargin: 8; top: parent.top; topMargin: 12 }
        spacing: 3

        Row {
            width: parent.width
            spacing: 6
            Text {
                text: root.n.appName || "Notificación"
                color: root.n.urgency === NotificationUrgency.Critical ? Theme.red : Theme.overlay1
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 3
                elide: Text.ElideRight
                width: Math.min(implicitWidth, parent.width - timeText.implicitWidth - 6)
            }
            Text {
                id: timeText
                text: "· " + Notifs.ago(root.entry.time, root.now)
                color: Theme.overlay0
                font.family: Theme.font
                font.pixelSize: Theme.fontSize - 3
            }
        }

        Text {
            width: parent.width
            text: root.n.summary
            color: Theme.text
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            font.bold: true
            elide: Text.ElideRight
        }

        Text {
            width: parent.width
            visible: text !== ""
            text: root.n.body
            textFormat: Text.StyledText
            color: Theme.subtext0
            font.family: Theme.font
            font.pixelSize: Theme.fontSize - 1
            wrapMode: Text.Wrap
            maximumLineCount: root.bodyLines
            elide: Text.ElideRight
        }

        Row {
            visible: root.actions.length > 0
            topPadding: 6
            spacing: 6
            Repeater {
                model: root.actions
                delegate: GlassButton {
                    required property var modelData
                    width: Math.max(80, metrics.width + 24)
                    height: 28
                    radius: 10
                    label: modelData.text
                    onClicked: {
                        // invoke() closes non-resident notifications by itself
                        modelData.invoke();
                    }
                    TextMetrics { id: metrics; text: modelData.text; font.family: Theme.font; font.pixelSize: Theme.fontSize - 2 }
                }
            }
        }
    }

    GlassButton {
        id: close
        anchors { right: parent.right; top: parent.top; margins: 10 }
        width: 24; height: 24; radius: 12
        sheen: false
        icon: Icons.close
        iconSize: 12
        iconColor: Theme.overlay1
        opacity: area.containsMouse || hovered ? 1 : 0
        readonly property bool hovered: closeHover.hovered
        HoverHandler { id: closeHover }
        Behavior on opacity { NumberAnimation { duration: 150 } }
        onClicked: Notifs.dismiss(root.n)
    }
}
