import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "config"

Item {
    id: root

    readonly property var size: Theme.popupSize(screen, 400)

    implicitWidth: row.implicitWidth + Theme.paddingM * 2
    implicitHeight: row.implicitHeight

    // UPower gives us a primary battery device directly
    readonly property var battery: UPower.displayDevice
    readonly property bool available: battery?.isLaptopBattery ?? false
    readonly property real percent: (battery?.percentage ?? 0) * 100
    readonly property bool charging: battery?.state === UPowerDeviceState.Charging || battery?.state === UPowerDeviceState.FullyCharged
    readonly property real timeToEmpty: battery?.timeToEmpty ?? 0      // seconds
    readonly property real timeToFull: battery?.timeToFull ?? 0

    // Nerd Font battery glyphs (0-100% in steps of 10)
    // Requires a Nerd Font; you have JetBrainsMono Nerd Font
    readonly property var dischargeIcons: ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
    readonly property var chargeIcons: ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]

    readonly property string icon: {
        const idx = Math.min(10, Math.floor(percent / 10));
        return charging ? chargeIcons[idx] : dischargeIcons[idx];
    }

    readonly property color iconColor: {
        if (charging)
            return Theme.green;
        if (percent <= 15)
            return Theme.red;
        if (percent <= 30)
            return Theme.yellow;
        return Theme.fg;
    }

    visible: available

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Theme.paddingS

        Text {
            text: root.icon
            color: root.iconColor
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeLarge
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: Math.round(root.percent) + "%"
            color: root.iconColor
            font.family: Theme.fontMono
            font.pixelSize: Theme.fontSize
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Hover popup
    property bool popupShouldShow: hoverArea.containsMouse || popup.contentHovered

    Timer {
        id: hideTimer
        interval: 200
        onTriggered: popup.visible = false
    }

    onPopupShouldShowChanged: {
        if (popupShouldShow) {
            hideTimer.stop();
            popup.visible = true;
        } else {
            hideTimer.restart();
        }
    }

    PopupWindow {
        id: popup
        property alias contentHovered: popupHover.containsMouse

        readonly property var screen: QsWindow.window?.screen ?? null
        readonly property var size: Theme.batterySize(screen)

        anchor {
            window: QsWindow.window
            rect.x: root.x + root.width / 2 - popup.width / 2
            rect.y: root.y + root.height
        }
        implicitWidth: size.width
        implicitHeight: content.implicitHeight + Theme.paddingL * 2
        color: "transparent"
        visible: false

        Rectangle {
            anchors.fill: parent
            color: Theme.bgAlt
            border.color: Theme.border
            border.width: Theme.popupBorderWidth
            radius: Theme.popupRadius

            MouseArea {
                id: popupHover
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.NoButton
            }

            Column {
                id: content
                anchors.fill: parent
                anchors.margins: Theme.paddingL
                spacing: Theme.paddingM

                Row {
                    width: parent.width
                    spacing: Theme.paddingL

                    Text {
                        text: root.icon
                        color: root.iconColor
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeLarge * 2.2
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 4

                        Text {
                            text: Math.round(root.percent) + "%"
                            color: Theme.fg
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeLarge * 1.4
                            font.bold: true
                        }

                        Text {
                            text: root.charging ? (root.battery?.state === UPowerDeviceState.FullyCharged ? "Fully charged" : "Charging · " + formatTime(root.timeToFull) + " to full") : "Discharging · " + formatTime(root.timeToEmpty) + " remaining"
                            color: Theme.fgDim
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: Theme.border
                }

                // // Battery health (capacity vs design capacity)
                // Text {
                //     width: parent.width
                //     text: "Health: " + Math.round((root.battery?.healthPercentage ?? 1) * 100) + "%"
                //     color: Theme.fgDim
                //     font.family: Theme.fontFamily
                //     font.pixelSize: Theme.fontSize
                // }

                Text {
                    width: parent.width
                    text: "Power: " + (root.battery?.changeRate?.toFixed(1) ?? "0") + " W"
                    color: Theme.fgDim
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                }
            }
        }
    }
    // ── Low battery notifications ───────────────────
    property int lastNotifiedThreshold: -1

    readonly property var thresholds: [20, 10, 5]  // warn at each

    function checkLowBattery() {
        if (charging || !available) {
            lastNotifiedThreshold = -1;
            return;
        }
        for (const t of thresholds) {
            if (percent <= t && lastNotifiedThreshold !== t) {
                notify(t);
                lastNotifiedThreshold = t;
                break;
            }
        }
    }

    function notify(threshold) {
        const urgency = threshold <= 5 ? "critical" : "normal";
        const msg = threshold <= 5 ? "Battery critical (" + Math.round(percent) + "%) — plug in now" : "Battery low: " + Math.round(percent) + "% remaining";
        Quickshell.execDetached(["notify-send", "-u", urgency, "-i", "battery-caution", "Battery", msg]);
    }

    onPercentChanged: checkLowBattery()
    onChargingChanged: checkLowBattery()

    // Helpers
    function formatTime(seconds) {
        if (!seconds || seconds <= 0)
            return "—";
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        if (h > 0)
            return h + "h " + m + "m";
        return m + "m";
    }
}
