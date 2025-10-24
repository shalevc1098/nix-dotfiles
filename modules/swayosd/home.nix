{
  services.swayosd.enable = true;

  wayland.windowManager.hyprland.settings = {
    bindsym = [
      "$mainMod, E, exec, uwsm app -- nautilus --new-window"
    ];
  };
}
