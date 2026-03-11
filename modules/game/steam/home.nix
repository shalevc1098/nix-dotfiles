{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
  ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class steam title:^Steam.*, center on"
    "match:class steam_app_.*, center on"
  ];
}
