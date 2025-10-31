{ inputs, ... }:
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
      "$mainMod, E, exec, uwsm app -- dolphin --new-window"
    ];

    windowrulev2 = [
      "float, class:org.freedesktop.impl.portal.desktop.kde"
      "size 60% 65%, class:org.freedesktop.impl.portal.desktop.kde"
    ];
  };
}
