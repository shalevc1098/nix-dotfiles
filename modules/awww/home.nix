{
  hyprLib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    awww
  ];

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "awww-daemon --format xrgb" ])
  ];
}
