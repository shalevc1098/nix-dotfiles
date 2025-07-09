{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xiccd
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "xiccd"
  ];
}
