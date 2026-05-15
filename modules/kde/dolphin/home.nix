{
  hyprLib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    configFile = {
      "kdeglobals" = {
        "General" = {
          "TerminalApplication" = "kitty";
        };
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      (hyprLib.mkBindExec "SUPER + E" "uwsm app -- dolphin --new-window")
    ];

    window_rule = [
      { match = { class = "org.freedesktop.impl.portal.desktop.kde"; }; float = true; size = [ "(monitor_w*0.6)" "(monitor_h*0.65)" ]; }
      { match = { class = "org.kde.dolphin"; }; opacity = "0.86 0.79"; }
    ];
  };

  programs.niri.settings = {
    binds = {
      "Mod+E".action.spawn = [ "dolphin" "--new-window" ];
    };
    window-rules = [
      {
        matches = [{ app-id = "^org\\.freedesktop\\.impl\\.portal\\.desktop\\.kde$"; }];
        open-floating = true;
        default-column-width.proportion = 0.6;
        default-window-height.proportion = 0.65;
      }
    ];
  };
}
