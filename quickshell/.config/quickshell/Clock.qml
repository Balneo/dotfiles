import QtQuick
import Quickshell
import "config"

Item {
    id: root
    implicitWidth: label.width
    implicitHeight: label.height

    property string currentTime: ""
    property string currentDate: ""

    property bool popupShouldShow: hoverArea.containsMouse || calendar.containsMouse
    // property bool popupShouldShow: hoverArea.containsMouse || popupHover.containsMouse

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true // fire on load dont wait 1s
        onTriggered: {
            const now = new Date();
            root.currentTime = Qt.formatDateTime(now, "HH:mm:ss");
            root.currentDate = Qt.formatDateTime(now, "ddd d MMM");
        }
    }

    Timer {
        id: hideTimer
        interval: 200
        onTriggered: popup.visible = false
    }

    onPopupShouldShowChanged: {
        if (popupShouldShow) {
            hideTimer.stop()
            popup.visible = true
        } else {
            hideTimer.restart()
        }
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: root.currentDate + " " + root.currentTime
        color: Theme.fg
        font.family: Theme.fontMono
        font.pixelSize: Theme.fontSizeLarge
    }

    PopupWindow {
        id: popup
        anchor {
            window: QsWindow.window
            rect.x: root.x + root.width / 2 - popup.width / 2
            rect.y: root.y + root.height + Theme.paddingS
        }
        implicitWidth: calendar.implicitWidth
        implicitHeight: calendar.implicitHeight
        color: "transparent"
        visible: hoverArea.containsMouse // || popupHover.containsMouse

        Rectangle {
            anchors.fill: parent
            color: Theme.bgAlt
            border.color: Theme.border
            border.width: Theme.popupBorderWidth
            radius: Theme.popupRadius

            // MouseArea {
            //     id: popupHover
            //     anchors.fill: parent
            //     hoverEnabled: true
            // }

            Calendar {
                id: calendar
                anchors.fill: parent
            }
        }
    }
}
