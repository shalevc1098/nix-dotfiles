{ hyprLib, ... }:
let
  profileName = "main";
in
{
  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "openrgb -p ${profileName}" ])
  ];
}
