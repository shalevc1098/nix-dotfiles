{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.gwenview
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class org.kde.gwenview, float on"
      "match:class org.kde.gwenview, size (monitor_w*0.6) (monitor_h*0.65)"
    ];
  };
}
