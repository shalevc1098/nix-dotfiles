{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    kdePackages.kate
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "org.kde.kate"; }; opacity = "0.86 0.79"; }
  ];
}