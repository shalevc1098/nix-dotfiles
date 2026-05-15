{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    anydesk
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "Anydesk"; }; float = true; size = [ "(monitor_w*0.6)" "(monitor_h*0.65)" ]; center = true; }
  ];

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^Anydesk$"; }];
      open-floating = true;
      default-column-width.proportion = 0.6;
      default-window-height.proportion = 0.65;
    }
  ];
}
