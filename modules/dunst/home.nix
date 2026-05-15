{ hyprLib, ... }:
{
  services.dunst = {
    enable = true;
  };

  programs.niri.settings.spawn-at-startup = [
    { command = [ "dunst" ]; }
  ];

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "dunst" ])
  ];
}
