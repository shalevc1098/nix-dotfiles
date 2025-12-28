{
  services.kdeconnect.enable = true;

  wayland.windowManager.hyprland.settings.exec-once = [
    "kdeconnect-indicator &"
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "kdeconnect-indicator" ]; }
  ];
}