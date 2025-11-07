{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.gwenview
  ];

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float, class:org.kde.gwenview"
      "size 60% 65%, class:org.kde.gwenview"
    ];
  };
}
