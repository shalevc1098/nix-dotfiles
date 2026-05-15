{ hyprLib, ... }:
{
  services.dunst = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "dunst" ])
  ];
}
