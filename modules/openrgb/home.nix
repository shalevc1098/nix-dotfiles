let
  profileName = "main";
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "openrgb -p ${profileName}"
    ];
  };

  programs.niri.settings.spawn-at-startup = [
    { command = [ "openrgb" "-p" profileName ]; }
  ];
}
