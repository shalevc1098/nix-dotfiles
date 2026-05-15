{ hyprLib, ... }:
{
  services.kdeconnect.enable = true;

  programs.niri.settings.spawn-at-startup = [
    { command = [ "kdeconnect-indicator" ]; }
  ];

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "kdeconnect-indicator &" ])
  ];
}