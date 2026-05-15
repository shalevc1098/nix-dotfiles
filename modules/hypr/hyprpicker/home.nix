{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkgs.hyprpicker
  ];

  wayland.windowManager.hyprland.settings.layer_rule = [
    { match = { namespace = "hyprpicker"; }; no_anim = true; }
  ];
}
