{
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
      "$mainMod, E, exec, uwsm app -- dolphin --new-window"
    ];

    windowrule = [
      "match:class org.freedesktop.impl.portal.desktop.kde, float on"
      "match:class org.freedesktop.impl.portal.desktop.kde, size (monitor_w*0.6) (monitor_h*0.65) "
    ];
  };
}
