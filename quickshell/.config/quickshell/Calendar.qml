import QtQuick
import QtQuick.Controls
import Quickshell
import "config"

Item {
    id: root

    readonly property var screen: QsWindow.window?.screen ?? null
    readonly property var size: Theme.calendarSize(screen)

    implicitWidth: size.width
    implicitHeight: size.height

    // Derive all internal sizes from our own dimensions
    readonly property real unit: height / 9          // vertical rhythm unit
    readonly property real headerHeight: unit * 1.5
    readonly property real weekdayHeight: unit * 1.0
    readonly property real gridHeight: unit * 6.0

    readonly property int baseFontSize: Math.round(width / 22)
    readonly property int headerFontSize: Math.round(width / 16)

    property date displayDate: new Date()
    property date today: new Date()

    readonly property int visibleRows: {
        // How many rows does this month actually need?
        const year = displayDate.getFullYear();
        const month = displayDate.getMonth();
        const firstDay = new Date(year, month, 1);
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        // Monday-first day-of-week index (0-6)
        const firstDow = (firstDay.getDay() + 6) % 7;
        // Total cells needed = leading blanks + days in month
        const totalCells = firstDow + daysInMonth;
        return Math.ceil(totalCells / 7);
    }

    function isoWeek(date) {
        const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
        const dayNum = d.getUTCDay() || 7;
        d.setUTCDate(d.getUTCDate() + 4 - dayNum);
        const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
        return Math.ceil(((d - yearStart) / 86400000 + 1) / 7);
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: root.today = new Date()
    }

    Timer {
        id: resetTimer
        interval: 5000
        onTriggered: root.displayDate = root.today
    }

    onContainsMouseChanged: {
        if (containsMouse) {
            resetTimer.stop();
        } else {
            resetTimer.restart();
        }
    }

    property alias containsMouse: hoverArea.containsMouse

    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingL
        spacing: 0  // proportional sizes handle rhythm now

        // ── Header: ‹  Month Year  › ────────────────────
        Item {
            width: parent.width
            height: root.headerHeight

            Text {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingM
                anchors.verticalCenter: parent.verticalCenter
                text: "‹"
                color: Theme.accent
                font.family: Theme.fontFamily
                font.pixelSize: root.headerFontSize
                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -Theme.paddingM
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        const d = new Date(root.displayDate);
                        d.setMonth(d.getMonth() - 1);
                        root.displayDate = d;
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                text: Qt.formatDate(root.displayDate, "MMMM yyyy")
                color: Theme.fg
                font.family: Theme.fontFamily
                font.pixelSize: root.baseFontSize
                font.bold: true
                font.capitalization: Font.Capitalize
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingM
                anchors.verticalCenter: parent.verticalCenter
                text: "›"
                color: Theme.accent
                font.family: Theme.fontFamily
                font.pixelSize: root.headerFontSize
                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -Theme.paddingM
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        const d = new Date(root.displayDate);
                        d.setMonth(d.getMonth() + 1);
                        root.displayDate = d;
                    }
                }
            }
        }

        // Replace DayOfWeekRow block with:
        Row {
            width: parent.width
            height: root.weekdayHeight
            spacing: Theme.paddingS

            Item {
                width: root.baseFontSize * 1.6
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "v"
                    color: Theme.fgDim
                    font.family: Theme.fontFamily
                    font.pixelSize: root.baseFontSize * 0.85
                    font.italic: true
                }
            }

            Rectangle {
                width: 1
                height: 0
            }  // invisible, just to match the grid separator space

            DayOfWeekRow {
                width: parent.width - root.baseFontSize * 1.6 - Theme.paddingS * 2 - 1
                height: parent.height
                locale: Qt.locale("sv_SE")
                delegate: Item {
                    implicitWidth: 1
                    implicitHeight: root.weekdayHeight
                    Text {
                        anchors.centerIn: parent
                        text: model.shortName
                        color: Theme.fgDim
                        font.family: Theme.fontFamily
                        font.pixelSize: root.baseFontSize * 0.85
                        font.capitalization: Font.AllUppercase
                    }
                }
            }
        }

        // ── Day grid with week numbers ─────────────────
        Row {
            width: parent.width
            height: root.gridHeight
            spacing: Theme.paddingS

            // Week number column
            Column {
                id: weekCol
                width: root.baseFontSize * 1.6
                height: parent.height

                property date firstVisible: {
                    // Find the Monday of the week containing the 1st of displayDate's month
                    const first = new Date(root.displayDate.getFullYear(), root.displayDate.getMonth(), 1);
                    const dow = (first.getDay() + 6) % 7;  // 0 = Monday, 6 = Sunday
                    first.setDate(first.getDate() - dow);
                    return first;
                }

                Repeater {
                    model: root.visibleRows
                    delegate: Item {
                        width: weekCol.width
                        height: weekCol.height / root.visibleRows + Theme.paddingM

                        property date rowDate: {
                            const d = new Date(weekCol.firstVisible);
                            d.setDate(d.getDate() + index * 7);
                            return d;
                        }

                        Text {
                            anchors.centerIn: parent
                            text: root.isoWeek(parent.rowDate)
                            color: Theme.fgDim
                            font.family: Theme.fontMono
                            font.pixelSize: root.baseFontSize * 0.85
                            opacity: 0.7
                        }
                    }
                }
            }

            // Vertical separator
            Rectangle {
                width: 1
                height: parent.height * 0.9
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.border
                opacity: 0.3
            }

            Grid {
                id: grid
                width: parent.width - weekCol.width - Theme.paddingS * 2 - 1
                height: parent.height
                columns: 7
                rows: root.visibleRows

                property int month: root.displayDate.getMonth()
                property int year: root.displayDate.getFullYear()

                property var days: {
                    const arr = [];
                    const firstDay = new Date(year, month, 1);
                    const firstDow = (firstDay.getDay() + 6) % 7;
                    // Start from the Monday of the first visible week
                    const start = new Date(firstDay);
                    start.setDate(start.getDate() - firstDow);
                    for (let i = 0; i < root.visibleRows * 7; i++) {
                        const d = new Date(start);
                        d.setDate(d.getDate() + i);
                        arr.push(d);
                    }
                    return arr;
                }

                Repeater {
                    model: grid.days

                    delegate: Item {
                        required property date modelData
                        width: grid.width / 7
                        height: grid.height / root.visibleRows

                        readonly property bool isToday: modelData.toDateString() === root.today.toDateString()
                        readonly property bool inMonth: modelData.getMonth() === grid.month

                        Rectangle {
                            visible: isToday
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height) * 0.75
                            height: width
                            radius: width / 2
                            color: Theme.accent
                            opacity: 0.25
                        }

                        Text {
                            anchors.centerIn: parent
                            text: modelData.getDate()
                            color: isToday ? Theme.accent : inMonth ? Theme.fg : Theme.fgDim
                            font.family: Theme.fontFamily
                            font.pixelSize: root.baseFontSize
                            font.bold: isToday
                            opacity: inMonth ? 1.0 : 0.4
                        }
                    }
                }
            }
        }
    }
    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        // Don't consume clicks — let them fall through to children
        acceptedButtons: Qt.NoButton
    }
}
