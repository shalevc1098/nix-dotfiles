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

  programs.niri.settings.spawn-at-startup = [
    { command = [ "xiccd" ]; }
  ];
}
