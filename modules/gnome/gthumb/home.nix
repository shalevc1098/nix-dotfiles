{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gthumb
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "org.gnome.gThumb"; }; float = true; size = [ "(monitor_w*0.6)" "(monitor_h*0.65)" ]; }
  ];
}
