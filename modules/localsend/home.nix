{ ... }:
{
  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "localsend_app"; }; float = true; size = [ "(monitor_w*0.55)" "(monitor_h*0.6)" ]; center = true; }
  ];

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^localsend_app$"; }];
      open-floating = true;
      default-column-width.proportion = 0.55;
      default-window-height.proportion = 0.6;
    }
  ];
}
