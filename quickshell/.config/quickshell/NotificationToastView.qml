import QtQuick

// Incoming notification: the island morphs into the card for a few seconds.
// Not interactive in the keyboard sense (never steals focus while typing);
// hovering keeps it open, clicking runs its default action.
IslandView {
    id: root
    mode: "notification"
    preferredWidth: 420
    preferredHeight: (card.item?.implicitHeight ?? 60) + 12

    HoverHandler { onHoveredChanged: Notifs.popupHeld = hovered }

    Loader {
        id: card
        anchors { left: parent.left; right: parent.right; top: parent.top; margins: 6 }
        active: !!Notifs.popup
        sourceComponent: NotificationCard {
            entry: Notifs.popup
            tint: "transparent"
            rim: "transparent"
            sheen: false
            bodyLines: 3
        }
    }
}
