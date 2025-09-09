{
  services.dunst = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "dunst"
  ];
}
