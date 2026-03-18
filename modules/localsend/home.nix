{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class localsend_app, float on"
      "match:class localsend_app, size (monitor_w*0.55) (monitor_h*0.6)"
      "match:class localsend_app, center on"
    ];
  };

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^localsend_app$"; }];
      open-floating = true;
      default-column-width.proportion = 0.55;
      default-window-height.proportion = 0.6;
    }
  ];
}
