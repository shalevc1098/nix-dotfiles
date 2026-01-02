{
  pkgs,
  ...
}:
{
  programs.vesktop = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class vesktop|discord|Discord, opacity 0.86 0.79"
  ];
}
