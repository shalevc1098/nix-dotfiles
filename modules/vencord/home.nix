{
  pkgs,
  ...
}:
{
  programs.vesktop = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "vesktop|discord|Discord"; }; opacity = "0.86 0.79"; }
  ];
}
