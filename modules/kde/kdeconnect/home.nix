{
  services.kdeconnect.enable = true;

  programs.niri.settings.spawn-at-startup = [
    { command = [ "kdeconnect-indicator" ]; }
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "kdeconnect-indicator &"
    ];
  };
}