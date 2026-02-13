#!/usr/bin/env bash
monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
workspaces=$(hyprctl workspaces -j)
ids=$(echo "$workspaces" | jq --arg m "$monitor" '[.[] | select(.monitor == $m and .id > 0) | .id] | sort')
current=$(hyprctl activeworkspace -j | jq -r .id)

case "$1" in
  next-new)
    next=$(echo "$ids" | jq --argjson c "$current" '[.[] | select(. > $c)] | .[0] // empty')
    if [ -n "$next" ]; then
      hyprctl dispatch workspace "$next"
    else
      windows=$(echo "$workspaces" | jq --argjson c "$current" '[.[] | select(.id == $c) | .windows] | .[0] // 0')
      global_max=$(echo "$workspaces" | jq '[.[].id | select(. > 0)] | max // 0')
      [ -n "$windows" ] && [ "$windows" -gt 0 ] && hyprctl dispatch workspace $((global_max + 1))
    fi
    ;;
  prev)
    prev=$(echo "$ids" | jq --argjson c "$current" '[.[] | select(. < $c)] | .[-1] // empty')
    [ -n "$prev" ] && hyprctl dispatch workspace "$prev"
    ;;
  move-next-new)
    next=$(echo "$ids" | jq --argjson c "$current" '[.[] | select(. > $c)] | .[0] // empty')
    if [ -n "$next" ]; then
      hyprctl dispatch movetoworkspace "$next"
    else
      windows=$(echo "$workspaces" | jq --argjson c "$current" '[.[] | select(.id == $c) | .windows] | .[0] // 0')
      global_max=$(echo "$workspaces" | jq '[.[].id | select(. > 0)] | max // 0')
      [ -n "$windows" ] && [ "$windows" -gt 1 ] && hyprctl dispatch movetoworkspace $((global_max + 1))
    fi
    ;;
  move-prev)
    prev=$(echo "$ids" | jq --argjson c "$current" '[.[] | select(. < $c)] | .[-1] // empty')
    [ -n "$prev" ] && hyprctl dispatch movetoworkspace "$prev"
    ;;
esac
