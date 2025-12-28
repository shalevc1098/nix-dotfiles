{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprlock || hyprctl dispatch exit"
    ];
  };

  programs.niri.settings.spawn-at-startup = [
    { command = [ "sh" "-c" "hyprlock || exit" ]; }
  ];
}