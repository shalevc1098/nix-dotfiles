{ hyprLib, ... }:
{
  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ ''hyprlock || hyprctl dispatch 'hl.dsp.exit()' '' ])
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "sh" "-c" "hyprlock || exit" ]; }
  ];
}