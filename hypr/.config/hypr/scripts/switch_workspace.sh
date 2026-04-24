#!/bin/bash
operation="$1"
workspace="$2"

monitor_id=$(hyprctl activeworkspace -j | jq -r ".monitorID")
workspace_id=$((monitor_id * 10 + workspace))

case "$operation" in
    switch)
        hyprctl dispatch moveworkspacetomonitor "$workspace_id" "$monitor_id"
        hyprctl dispatch workspace "$workspace_id"
        ;;
    move)
        hyprctl dispatch moveworkspacetomonitor "$workspace_id" "$monitor_id"
        hyprctl dispatch movetoworkspace "$workspace_id"
        ;;
esac

hyprctl dispatch renameworkspace "$workspace_id" "$workspace"
