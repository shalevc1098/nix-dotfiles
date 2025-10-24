let
  profileName = "main";
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "openrgb -p ${profileName}"
    ];
  };
}
