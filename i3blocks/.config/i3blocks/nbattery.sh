#!/bin/bash
# ~/.config/i3blocks/nbattery
# Nerd Font battery icons
#

#
# Get the battery info
#

battery_info=$(acpi -b)
status=$(echo "$battery_info" | awk -F ', ' '{print $1}')
perc=$(echo "$battery_info" | awk -F ', ' '{print $2}' | tr -d '%')

# Determine icon
icon=""
if [[ "$status" != *"Discharging" ]]; then
    icon="\uF0E7"   # ⚡ Charging
elif  [ $perc -ge 80 ]; then
    icon="\uF240"  # 
elif [ $perc -ge 60 ]; then
    icon="\uF241"  # 
elif [ $perc -ge 40 ]; then
    icon="\uF242"  # 
elif [ $perc -ge 20 ]; then
    icon="\uF243"  # 
else
    icon="\uF244"  # 
fi

#
# Print output
#
echo -e "$icon $perc%  "
