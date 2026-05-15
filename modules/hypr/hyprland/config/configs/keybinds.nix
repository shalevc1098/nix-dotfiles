{ hyprLib, ... }:
let
  ws = "${../../scripts/workspace_action.sh}";

  mkBind = hyprLib.mkBind;
  mkBindFlags = hyprLib.mkBindFlags;
  mkBindExec = hyprLib.mkBindExec;
  mkBindExecFlags = hyprLib.mkBindExecFlags;

  # Common dispatchers
  focusDir = d: mkBind "SUPER + ${d.key}" ''hl.dsp.focus({ direction = "${d.dir}" })'';
  moveDir = d: mkBind "SUPER + SHIFT + ${d.key}" ''hl.dsp.window.move({ direction = "${d.dir}" })'';
  focusWs = keys: w: mkBind keys ''hl.dsp.focus({ workspace = "${w}" })'';
  moveToWs = keys: w: mkBind keys ''hl.dsp.window.move({ workspace = "${w}" })'';

  dirs = [
    { key = "Left"; dir = "l"; }
    { key = "Right"; dir = "r"; }
    { key = "Up"; dir = "u"; }
    { key = "Down"; dir = "d"; }
  ];
in
{
  bind =
    [
      (mkBind "SUPER + Q" "hl.dsp.window.close()") # Kill Focused Window
    ]
    ++ (map focusDir dirs) # Move focus l/r/u/d
    ++ [
      (mkBind "SUPER + BracketLeft" ''hl.dsp.focus({ direction = "l" })'')
      (mkBind "SUPER + BracketRight" ''hl.dsp.focus({ direction = "r" })'')
    ]
    ++ (map moveDir dirs) # Move window l/r/u/d
    ++ [
      (mkBind "SUPER + ALT + Space" ''hl.dsp.window.float({ action = "toggle" })'') # Toggle floating
      (mkBind "SUPER + ALT + F" "hl.dsp.window.fullscreen_state({ internal = 0, client = 3 })") # Fake fullscreen
      (mkBind "SUPER + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'') # Real fullscreen
      (mkBind "SUPER + D" ''hl.dsp.window.fullscreen({ mode = "maximized" })'') # Fullscreen with gaps

      # Workspace Actions - Switch to workspace (via script)
      (mkBindExec "SUPER + 1" "${ws} workspace 1")
      (mkBindExec "SUPER + 2" "${ws} workspace 2")
      (mkBindExec "SUPER + 3" "${ws} workspace 3")
      (mkBindExec "SUPER + 4" "${ws} workspace 4")
      (mkBindExec "SUPER + 5" "${ws} workspace 5")
      (mkBindExec "SUPER + 6" "${ws} workspace 6")
      (mkBindExec "SUPER + 7" "${ws} workspace 7")
      (mkBindExec "SUPER + 8" "${ws} workspace 8")
      (mkBindExec "SUPER + 9" "${ws} workspace 9")
      (mkBindExec "SUPER + 0" "${ws} workspace 10")

      # Workspace Actions - Move to workspace silently (via script)
      (mkBindExec "SUPER + ALT + 1" "${ws} movetoworkspacesilent 1")
      (mkBindExec "SUPER + ALT + 2" "${ws} movetoworkspacesilent 2")
      (mkBindExec "SUPER + ALT + 3" "${ws} movetoworkspacesilent 3")
      (mkBindExec "SUPER + ALT + 4" "${ws} movetoworkspacesilent 4")
      (mkBindExec "SUPER + ALT + 5" "${ws} movetoworkspacesilent 5")
      (mkBindExec "SUPER + ALT + 6" "${ws} movetoworkspacesilent 6")
      (mkBindExec "SUPER + ALT + 7" "${ws} movetoworkspacesilent 7")
      (mkBindExec "SUPER + ALT + 8" "${ws} movetoworkspacesilent 8")
      (mkBindExec "SUPER + ALT + 9" "${ws} movetoworkspacesilent 9")
      (mkBindExec "SUPER + ALT + 0" "${ws} movetoworkspacesilent 10")

      # Mouse — move window to workspace (relative)
      (moveToWs "SUPER + SHIFT + mouse_down" "r-1")
      (moveToWs "SUPER + SHIFT + mouse_up" "r+1")
      (moveToWs "SUPER + ALT + mouse_down" "-1")
      (moveToWs "SUPER + ALT + mouse_up" "+1")

      # Page Up/Down — move window to workspace
      (moveToWs "SUPER + ALT + Page_Down" "+1")
      (moveToWs "SUPER + ALT + Page_Up" "-1")
      (moveToWs "SUPER + SHIFT + Page_Down" "r+1")
      (moveToWs "SUPER + SHIFT + Page_Up" "r-1")
      (moveToWs "CTRL + SUPER + SHIFT + Right" "r+1")
      (moveToWs "CTRL + SUPER + SHIFT + Left" "r-1")

      # Workspace navigation (focus)
      (focusWs "CTRL + SUPER + Right" "r+1")
      (focusWs "CTRL + SUPER + Left" "r-1")
      (focusWs "CTRL + SUPER + ALT + Right" "m+1")
      (focusWs "CTRL + SUPER + ALT + Left" "m-1")
      (focusWs "SUPER + Page_Down" "+1")
      (focusWs "SUPER + Page_Up" "-1")
      (focusWs "CTRL + SUPER + Page_Down" "r+1")
      (focusWs "CTRL + SUPER + Page_Up" "r-1")
      (focusWs "SUPER + mouse_up" "+1")
      (focusWs "SUPER + mouse_down" "-1")
      (focusWs "CTRL + SUPER + mouse_up" "r+1")
      (focusWs "CTRL + SUPER + mouse_down" "r-1")

      # Audio mute (was bindl — locked)
      (mkBindExecFlags "ALT + XF86AudioMute" "wpctl set-mute @DEFAULT_SOURCE@ toggle" { locked = true; })
      (mkBindExecFlags "SUPER + XF86AudioMute" "wpctl set-mute @DEFAULT_SOURCE@ toggle" { locked = true; })
      (mkBindExecFlags "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" { locked = true; })
      (mkBindExecFlags "SUPER + SHIFT + M" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" { locked = true; })

      # Media playback (was bindl — locked)
      (mkBindExecFlags "XF86AudioPlay" "playerctl play-pause" { locked = true; })
      (mkBindExecFlags "XF86AudioPause" "playerctl play-pause" { locked = true; })
      (mkBindExecFlags "XF86AudioNext" "playerctl next" { locked = true; })
      (mkBindExecFlags "XF86AudioPrev" "playerctl previous" { locked = true; })

      # Volume (was bindle — locked + repeating)
      (mkBindExecFlags "XF86AudioLowerVolume" "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" { locked = true; repeating = true; })
      (mkBindExecFlags "XF86AudioRaiseVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" { locked = true; repeating = true; })

      # Mouse drag/resize (was bindm — mouse flag)
      (mkBindFlags "SUPER + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
      (mkBindFlags "SUPER + mouse:273" "hl.dsp.window.resize()" { mouse = true; })
    ];
}
