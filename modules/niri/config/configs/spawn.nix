# Niri spawn-at-startup (equivalent to hyprland exec-once)
{
  spawn-at-startup = [
    { command = [ "hyprlock" ]; }
    { command = [ "hypridle" ]; }
    { command = [ "dbus-update-activation-environment" "--all" ]; }
    { command = [ "sh" "-c" "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" ]; }
  ];
}
