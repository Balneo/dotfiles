import QtQuick
import Quickshell
import Quickshell.Hyprland
import "config"

Item {
    id: root

    // Which bar/screen are we on?
    readonly property var screen: QsWindow.window?.screen ?? null
    readonly property var monitor: Hyprland.monitors.values.find(m => m.name === screen?.name) ?? null
    readonly property int monitorId: monitor?.id ?? 0

    // Filter workspaces to only this monitor
    readonly property var myWorkspaces: {
        const all = Hyprland.workspaces.values;
        return all.filter(w => w.monitor?.id === monitorId).sort((a, b) => a.id - b.id);
    }

    readonly property int activeId: monitor?.activeWorkspace?.id ?? -1

    implicitWidth: row.implicitWidth + Theme.paddingL * 2
    implicitHeight: Theme.barHeight

    // Scroll to cycle
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0)
                root.switchRelative(-1);
            else
                root.switchRelative(1);
        }
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Theme.paddingS

        Repeater {
            model: 10   // always show 1..10, even if some don't exist yet

            delegate: Item {
                id: cell
                required property int index
                readonly property int wsNumber: index + 1
                readonly property int wsId: root.monitorId * 10 + wsNumber

                readonly property var workspace: root.myWorkspaces.find(w => w.id === wsId) ?? null

                readonly property bool isActive: root.activeId === wsId
                readonly property bool hasWindows: (workspace?.toplevels?.values?.length ?? 0) > 0

                // The cell itself grows when active — Row reflows correctly
                implicitWidth: isActive ? Theme.fontSizeLarge * 2.2 : Theme.fontSizeLarge * 1.4
                implicitHeight: Theme.fontSizeLarge * 1.4

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutQuad
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    radius: height / 2
                    color: cell.isActive ? Theme.accent : cell.hasWindows ? Theme.bgAlt : "transparent"
                    border.color: cell.hasWindows && !cell.isActive ? Theme.border : "transparent"
                    border.width: 1

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: cell.wsNumber
                    color: cell.isActive ? Theme.bg : cell.hasWindows ? Theme.fg : Theme.fgDim
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    font.bold: cell.isActive
                    opacity: cell.isActive || cell.hasWindows ? 1.0 : 0.5
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            root.switchTo(cell.wsNumber);
                        } else if (mouse.button === Qt.RightButton) {
                            root.moveActiveTo(cell.wsNumber);
                        }
                    }
                }
            }
        }
    }

    // ── Actions ─────────────────────────────────────

    function switchTo(workspaceNumber) {
        // Matches your switch_workspace.sh logic exactly
        const id = monitorId * 10 + workspaceNumber;
        Hyprland.dispatch(`moveworkspacetomonitor ${id} ${monitorId}`);
        Hyprland.dispatch(`workspace ${id}`);
        Hyprland.dispatch(`renameworkspace ${id} ${workspaceNumber}`);
    }

    function moveActiveTo(workspaceNumber) {
        const id = monitorId * 10 + workspaceNumber;
        Hyprland.dispatch(`moveworkspacetomonitor ${id} ${monitorId}`);
        Hyprland.dispatch(`movetoworkspace ${id}`);
        Hyprland.dispatch(`renameworkspace ${id} ${workspaceNumber}`);
    }

    function switchRelative(delta) {
        const currentNum = activeId - monitorId * 10;
        let next = currentNum + delta;
        if (next < 1)
            next = 10;
        if (next > 10)
            next = 1;
        switchTo(next);
    }
}
