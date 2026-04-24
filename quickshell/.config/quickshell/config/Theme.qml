pragma Singleton
import QtQuick
import "themes"

QtObject {
    id: root

    property string themeName: "tokyo"

    readonly property var themeOrder: ["tokyo", "gruvbox", "catppuccin"]

    // Current palette — pick the matching singleton
    readonly property var palette: {
        switch (themeName) {
            case "tokyo":      return Tokyo
            case "gruvbox":    return Gruvbox
            case "catppuccin": return Catppuccin
            default:           return Tokyo
        }
    }

    // ── Typed color properties that reference the palette ────
    readonly property color bg:     palette.bg
    readonly property color bgAlt:  palette.bgAlt
    readonly property color fg:     palette.fg
    readonly property color fgDim:  palette.fgDim
    readonly property color border: palette.border
    readonly property color accent: palette.accent
    readonly property color red:    palette.red
    readonly property color green:  palette.green
    readonly property color yellow: palette.yellow


    // ── WARNINGS ──────────────────────────
    readonly property color urgent: red
    readonly property color warning: yellow
    readonly property color success: green


    // ── Typography, spacing, etc. (unchanged) ────────
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property string fontMono: "JetBrainsMono Nerd Font Mono"
    readonly property int fontSize: 14
    readonly property int fontSizeSmall: 12
    readonly property int fontSizeLarge: 18
    readonly property int paddingS: 4
    readonly property int paddingM: 8
    readonly property int paddingL: 16
    readonly property int barHeight: 30
    readonly property int popupRadius: 8
    readonly property int popupBorderWidth: 1

    // ── Sizing helpers ──────────────────────────────
    function calendarSize(screen) {
        if (!screen) return { width: 280, height: 260 }
        const w = screen.width
        if (w >= 3840)      return { width: 420, height: 380 }
        else if (w >= 2240) return { width: 300, height: 280 }
        else                return { width: 260, height: 240 }
    }

    function batterySize(screen) {
        if (!screen) return { width: 320, height: 160 }
        const w = screen.width
        if (w >= 3840)      return { width: 480, height: 220 }
        else if (w >= 2240) return { width: 340, height: 170 }
        else                return { width: 300, height: 150 }
    }

    function cycleTheme() {
        const current = themeOrder.indexOf(themeName)
        const next = (current + 1) % themeOrder.length
        themeName = themeOrder[next]
    }
}
