#!/bin/bash
# Usage: toggle_bar.sh [waybar|quickshell|toggle]

ACTION="${1:-toggle}"

current_bar() {
    pgrep -x waybar >/dev/null && { echo waybar; return; }
    pgrep -x qs >/dev/null && { echo quickshell; return; }
    echo none
}

kill_bars() {
    pkill -x waybar 2>/dev/null
    pkill -x qs     2>/dev/null
    # let layer surfaces unregister before the next bar claims a zone
    sleep 0.2
}

start_waybar() {
    setsid -f waybar >/dev/null; 2>&1
}

start_quickshell() {
    setsid -f qs     >/dev/null; 2>&1
}

case "$ACTION" in
    waybar)             kill_bars; start_waybar ;;
    quickshell|qs)      kill_bars; start_quickshell ;;
    toggle)
        case "$(current_bar)" in
            waybar)         kill_bars; start_quickshell ;;
            quickshell)     kill_bars; start_waybar ;;
            none)           start_waybar ;;
        esac
        ;;
esac
