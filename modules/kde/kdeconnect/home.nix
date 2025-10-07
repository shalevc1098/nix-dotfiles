{
  services.kdeconnect.enable = true;

  wayland.windowManager.hyprland.settings.exec-once = [
    "kdeconnect-indicator &"
  ];
}