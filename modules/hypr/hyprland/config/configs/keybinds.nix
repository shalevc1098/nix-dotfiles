{
  "$mainMod" = "SUPER";

  bind = [
    # "Super, Super_L, exec, pgrep quickshell && hyprctl dispatch global quickshell:overviewToggle || (pgrep wofi && pkill wofi || wofi)"
    # "Ctrl+Super, R, exec, pkill quickshell; sleep 0.2 && quickshell &" # Restart quickshell
    "Super, Q, killactive" # Kill Focused Window
    "Super, Left, movefocus, l" # Move Window Focus Left
    "Super, Right, movefocus, r" # Move Window Focus Right
    "Super, Up, movefocus, u" # Move Window Focus Up
    "Super, Down, movefocus, d" # Move Window Focus Down
    "Super, BracketLeft, movefocus, l" # Move Window Focus Left
    "Super, BracketRight, movefocus, r" # Move Window Focus Right
    "Super+Shift, Left, movewindow, l" # Move Window Left
    "Super+Shift, Right, movewindow, r" # Move Window Right
    "Super+Shift, Up, movewindow, u" # Move Window Up
    "Super+Shift, Down, movewindow, d" # Move Window Down
    "Super+Alt, Space, togglefloating," # Toggle Floating Window
    "Super+Alt, F, fullscreenstate, 0 3" # Toggle Fake Fullscreen
    "Super, F, fullscreen, 0" # Toggle Fullscreen
    "Super, D, fullscreen, 1" # Toggle Fullscreen With Gaps
    
    # Workspace Actions - Switch to workspace
    "Super, 1, exec, ${../../scripts/workspace_action.sh} workspace 1"
    "Super, 2, exec, ${../../scripts/workspace_action.sh} workspace 2"
    "Super, 3, exec, ${../../scripts/workspace_action.sh} workspace 3"
    "Super, 4, exec, ${../../scripts/workspace_action.sh} workspace 4"
    "Super, 5, exec, ${../../scripts/workspace_action.sh} workspace 5"
    "Super, 6, exec, ${../../scripts/workspace_action.sh} workspace 6"
    "Super, 7, exec, ${../../scripts/workspace_action.sh} workspace 7"
    "Super, 8, exec, ${../../scripts/workspace_action.sh} workspace 8"
    "Super, 9, exec, ${../../scripts/workspace_action.sh} workspace 9"
    "Super, 0, exec, ${../../scripts/workspace_action.sh} workspace 10"
    
    # Workspace Actions - Move to workspace silently
    "Super+Alt, 1, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 1"
    "Super+Alt, 2, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 2"
    "Super+Alt, 3, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 3"
    "Super+Alt, 4, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 4"
    "Super+Alt, 5, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 5"
    "Super+Alt, 6, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 6"
    "Super+Alt, 7, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 7"
    "Super+Alt, 8, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 8"
    "Super+Alt, 9, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 9"
    "Super+Alt, 0, exec, ${../../scripts/workspace_action.sh} movetoworkspacesilent 10"
    
    # Mouse workspace actions
    "Super+Shift, mouse_down, movetoworkspace, r-1"
    "Super+Shift, mouse_up, movetoworkspace, r+1"
    "Super+Alt, mouse_down, movetoworkspace, -1"
    "Super+Alt, mouse_up, movetoworkspace, +1"
    
    # Page Up/Down workspace actions
    "Super+Alt, Page_Down, movetoworkspace, +1"
    "Super+Alt, Page_Up, movetoworkspace, -1"
    "Super+Shift, Page_Down, movetoworkspace, r+1"
    "Super+Shift, Page_Up, movetoworkspace, r-1"
    "Ctrl+Super+Shift, Right, movetoworkspace, r+1"
    "Ctrl+Super+Shift, Left, movetoworkspace, r-1"
    
    # Workspace navigation
    "Ctrl+Super, Right, workspace, r+1"
    "Ctrl+Super, Left, workspace, r-1"
    "Ctrl+Super+Alt, Right, workspace, m+1"
    "Ctrl+Super+Alt, Left, workspace, m-1"
    "Super, Page_Down, workspace, +1"
    "Super, Page_Up, workspace, -1"
    "Ctrl+Super, Page_Down, workspace, r+1"
    "Ctrl+Super, Page_Up, workspace, r-1"
    "Super, mouse_up, workspace, +1"
    "Super, mouse_down, workspace, -1"
    "Ctrl+Super, mouse_up, workspace, r+1"
    "Ctrl+Super, mouse_down, workspace, r-1"
  ];

  bindl = [
    "Alt, XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
    "Super, XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    "Super+Shift, M, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    
    # Media playback controls
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioPause, exec, playerctl play-pause"
    ", XF86AudioNext, exec, playerctl next"
    ", XF86AudioPrev, exec, playerctl previous"
    # "Super+Shift, P, exec, playerctl play-pause" # Play/pause
    # "Super+Shift, N, exec, playerctl next" # Next track
    # "Super+Shift, B, exec, playerctl previous" # Previous track
  ];

  bindle = [
    ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
  ];

  bindm = [
    "Super, mouse:272, movewindow" # Move Window
    "Super, mouse:273, resizewindow" # Resize Window
  ];
}
