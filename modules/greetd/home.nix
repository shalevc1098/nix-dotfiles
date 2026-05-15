{
  hyprLib,
  ...
}:
{
  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "hyprlock || hyprctl dispatch 'hl.dsp.exit()' " ])
  ];
}
