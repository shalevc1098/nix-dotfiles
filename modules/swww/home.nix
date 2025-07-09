{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "swww-daemon --format xrgb"
    "exec-once = sleep 0.5; swww img ~/wallpaper.jpg --transition-step 100 --transition-fps 120 --transition-type grow --transition-angle 30 --transition-duration 1" # TODO: remove
  ];
}
