{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    swww
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "swww-daemon" "--format" "xrgb" ]; }
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww-daemon --format xrgb"
      # "exec-once = sleep 0.5; swww img ~/wallpaper.png --transition-step 100 --transition-fps 120 --transition-type grow --transition-angle 30 --transition-duration 1" # TODO: remove
    ];
  };
}
