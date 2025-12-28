{
  services.dunst = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "dunst"
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "dunst" ]; }
  ];
}
