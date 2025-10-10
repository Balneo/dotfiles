#!/bin/bash
BAT=/sys/class/power_supply/BAT0
LEVEL=$(cat $BAT/capacity)
STATUS=$(cat $BAT/status)

if [[ "$STATUS" == "Discharging" ]]; then
    if (( LEVEL <= 10 )); then
        notify-send -u critical "Battery critically low" "Level: ${LEVEL}%"
    elif (( LEVEL <= 20 )); then
        notify-send -u normal "Battery low" "Level: ${LEVEL}%"
    fi
fi



