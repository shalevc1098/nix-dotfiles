{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    kdePackages.kate
  ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class org.kde.kate, opacity 0.86 0.79"
  ];
}