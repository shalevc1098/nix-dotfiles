{ hyprLib, ... }:
{
  services.kdeconnect.enable = true;

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "kdeconnect-indicator &" ])
  ];
}