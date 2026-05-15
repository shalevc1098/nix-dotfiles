{
  hyprLib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    awww
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "awww-daemon" "--format" "xrgb" ]; }
  ];

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "awww-daemon --format xrgb" ])
  ];
}
