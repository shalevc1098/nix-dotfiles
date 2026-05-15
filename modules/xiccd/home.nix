{
  hyprLib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xiccd
  ];

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "xiccd" ])
  ];
}
