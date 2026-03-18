{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
  ];

  home.sessionVariables = {
    STEAM_DISABLE_WAYLAND = 1;
  };

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class steam, float on"
    "match:class steam title:^Steam$, size (monitor_w*0.6) (monitor_h*0.65)"
    "match:class steam title:^Steam$, center on"
    "match:class steam_app_.*, center on"
  ];
}
