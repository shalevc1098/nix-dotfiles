{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (bottles.override { removeWarningPopup = true; })
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "com.usebottles.bottles"; }; opacity = "0.86 0.79"; }
  ];
}
