{ hyprLib, ... }:
let
  profileName = "main";
in
{
  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "openrgb -p ${profileName}" ])
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "openrgb" "-p" profileName ]; }
  ];
}
