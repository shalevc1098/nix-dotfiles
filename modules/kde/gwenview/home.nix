{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.gwenview
    kdePackages.kimageformats
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class org.kde.gwenview, float on"
      "match:class org.kde.gwenview, size (monitor_w*0.6) (monitor_h*0.65)"
      "match:class org.kde.gwenview, center on"
    ];
  };

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^org\\.kde\\.gwenview$"; }];
      open-floating = true;
      default-column-width.proportion = 0.6;
      default-window-height.proportion = 0.65;
    }
  ];
}
