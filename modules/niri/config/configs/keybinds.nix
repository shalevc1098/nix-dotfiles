{
  binds = {
    # Window Management
    "Mod+Q" = { repeat = false; action.close-window = {}; };
    "Mod+Left".action.focus-column-left = {};
    "Mod+Right".action.focus-column-right = {};
    "Mod+Up".action.focus-window-up = {};
    "Mod+Down".action.focus-window-down = {};
    "Mod+BracketLeft".action.focus-column-left = {};
    "Mod+BracketRight".action.focus-column-right = {};
    "Mod+Shift+Left".action.move-column-left = {};
    "Mod+Shift+Right".action.move-column-right = {};
    "Mod+Shift+Up".action.move-window-up = {};
    "Mod+Shift+Down".action.move-window-down = {};
    "Mod+Alt+Space".action.toggle-window-floating = {};
    "Mod+F".action.fullscreen-window = {};
    "Mod+D".action.maximize-column = {};
    "Mod+Alt+F".action.toggle-windowed-fullscreen = {};

    # Workspaces 1-10
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+0".action.focus-workspace = 10;

    # Move to workspace
    "Mod+Alt+1".action.move-column-to-workspace = 1;
    "Mod+Alt+2".action.move-column-to-workspace = 2;
    "Mod+Alt+3".action.move-column-to-workspace = 3;
    "Mod+Alt+4".action.move-column-to-workspace = 4;
    "Mod+Alt+5".action.move-column-to-workspace = 5;
    "Mod+Alt+6".action.move-column-to-workspace = 6;
    "Mod+Alt+7".action.move-column-to-workspace = 7;
    "Mod+Alt+8".action.move-column-to-workspace = 8;
    "Mod+Alt+9".action.move-column-to-workspace = 9;
    "Mod+Alt+0".action.move-column-to-workspace = 10;

    # Workspace navigation (scroll wheel)
    "Mod+WheelScrollUp".action.focus-workspace-up = {};
    "Mod+WheelScrollDown".action.focus-workspace-down = {};
    "Mod+Shift+WheelScrollUp".action.move-column-to-workspace-up = {};
    "Mod+Shift+WheelScrollDown".action.move-column-to-workspace-down = {};
    "Mod+Alt+WheelScrollUp".action.move-column-to-workspace-up = {};
    "Mod+Alt+WheelScrollDown".action.move-column-to-workspace-down = {};
    "Mod+Ctrl+WheelScrollUp".action.focus-workspace-up = {};
    "Mod+Ctrl+WheelScrollDown".action.focus-workspace-down = {};

    # Workspace navigation (Page Up/Down)
    "Mod+Page_Up".action.focus-workspace-up = {};
    "Mod+Page_Down".action.focus-workspace-down = {};
    "Mod+Shift+Page_Up".action.move-column-to-workspace-up = {};
    "Mod+Shift+Page_Down".action.move-column-to-workspace-down = {};
    "Mod+Alt+Page_Up".action.move-column-to-workspace-up = {};
    "Mod+Alt+Page_Down".action.move-column-to-workspace-down = {};
    "Mod+Ctrl+Page_Up".action.focus-workspace-up = {};
    "Mod+Ctrl+Page_Down".action.focus-workspace-down = {};

    # Workspace navigation (arrow keys)
    "Mod+Ctrl+Left".action.focus-workspace-up = {};
    "Mod+Ctrl+Right".action.focus-workspace-down = {};
    "Mod+Ctrl+Shift+Left".action.move-column-to-workspace-up = {};
    "Mod+Ctrl+Shift+Right".action.move-column-to-workspace-down = {};

    # Monitor switching
    "Mod+Ctrl+Alt+Left".action.focus-monitor-left = {};
    "Mod+Ctrl+Alt+Right".action.focus-monitor-right = {};

    # Volume/Media (allow-when-locked)
    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
    };
    "Alt+XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
    };
    "Mod+XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
    };
    "Mod+Shift+M" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
    };
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+" ];
    };
    "XF86AudioPlay" = {
      allow-when-locked = true;
      action.spawn = [ "playerctl" "play-pause" ];
    };
    "XF86AudioPause" = {
      allow-when-locked = true;
      action.spawn = [ "playerctl" "play-pause" ];
    };
    "XF86AudioNext" = {
      allow-when-locked = true;
      action.spawn = [ "playerctl" "next" ];
    };
    "XF86AudioPrev" = {
      allow-when-locked = true;
      action.spawn = [ "playerctl" "previous" ];
    };
  };
}
