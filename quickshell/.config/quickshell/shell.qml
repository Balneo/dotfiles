import Quickshell
import QtQuick
import "config"
import Quickshell.Hyprland

Scope {
    GlobalShortcut {
        name: "cycle-theme"
        onPressed: Theme.cycleTheme()
    }

    PanelWindow {
        id: root
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: Theme.barHeight
        color: Theme.bg

        Workspaces {
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingL
            anchors.verticalCenter: parent.verticalCenter
        }

        Clock {
            anchors.centerIn: parent
        }

        Battery {
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingL
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
