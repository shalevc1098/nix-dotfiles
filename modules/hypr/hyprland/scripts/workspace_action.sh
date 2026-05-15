#!/usr/bin/env bash
action="$1"
n="$2"
target=$(((($(hyprctl activeworkspace -j | jq -r .id) - 1) / 10) * 10 + n))

case "$action" in
  workspace)
    hyprctl dispatch "hl.dsp.focus({ workspace = \"$target\" })"
    ;;
  movetoworkspacesilent)
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"$target\", follow = false })"
    ;;
  *)
    echo "unknown action: $action" >&2
    exit 1
    ;;
esac
