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
}
