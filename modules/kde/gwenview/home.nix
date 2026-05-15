{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.gwenview
    kdePackages.kimageformats
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "org.kde.gwenview"; }; float = true; size = [ "(monitor_w*0.6)" "(monitor_h*0.65)" ]; center = true; }
  ];
}
