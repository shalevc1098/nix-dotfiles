{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkgs.hyprpicker
  ];

  wayland.windowManager.hyprland.settings.layerrule = [
    "noanim, hyprpicker"
  ];
}
