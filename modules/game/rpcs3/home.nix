{ ... }:
{
  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "rpcs3"; }; float = true; center = true; }
  ];
}
