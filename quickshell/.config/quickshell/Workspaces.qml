import QtQuick
import Quickshell.Hyprland

// iOS page-dot workspaces: the active one stretches into a pill
Item {
    implicitWidth: dots.implicitWidth
    implicitHeight: Theme.barHeight

    function focusRelative(step) {
        const ws = step > 0 ? "e+1" : "e-1";
        Hyprland.dispatch(Hyprland.usingLua
            ? `hl.dsp.focus({ workspace = '${ws}' })`
            : `workspace ${ws}`);
    }

    WheelHandler {
        onWheel: event => focusRelative(event.angleDelta.y > 0 ? -1 : 1)
    }

    Row {
        id: dots
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Repeater {
            model: Hyprland.workspaces.values.filter(w => w.id > 0).sort((a, b) => a.id - b.id)

            delegate: Rectangle {
                required property var modelData

                anchors.verticalCenter: parent.verticalCenter
                width: modelData.active ? 26 : 8
                height: 8
                radius: 4
                color: modelData.urgent ? Theme.red
                    : modelData.active ? Theme.mauve
                    : area.containsMouse ? Theme.lavender
                    : Theme.overlay0

                Behavior on width { NumberAnimation { duration: 450; easing.type: Easing.OutBack; easing.overshoot: 1.6 } }
                Behavior on color { ColorAnimation { duration: 200 } }

                MouseArea {
                    id: area
                    anchors.fill: parent
                    anchors.margins: -5
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: modelData.activate()
                }
            }
        }
    }
}
