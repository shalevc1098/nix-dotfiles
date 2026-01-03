{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xiccd
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "xiccd" ]; }
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "xiccd"
    ];
  };
}
