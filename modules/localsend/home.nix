{ ... }:
{
  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "localsend_app"; }; float = true; size = [ "(monitor_w*0.55)" "(monitor_h*0.6)" ]; center = true; }
  ];
}
