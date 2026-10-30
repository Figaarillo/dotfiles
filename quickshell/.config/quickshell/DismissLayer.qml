import QtQuick
import Quickshell
import Quickshell.Wayland

// Invisible full-screen catcher under the island: a click anywhere outside it
// closes the open view. Replaces HyprlandFocusGrab, which can't coexist with
// the Exclusive keyboard focus the island needs to accept typing right away.
// It starts below the bar row, so bar modules stay clickable and switch views.
PanelWindow {
    anchors { top: true; bottom: true; left: true; right: true }
    margins.top: Theme.barMargin + Theme.barHeight
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    visible: ShellState.interactive

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell-dismiss"

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons
        onPressed: ShellState.close()
    }
}
