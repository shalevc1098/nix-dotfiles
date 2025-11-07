{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gthumb
  ];

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float, class:org.gnome.gThumb"
      "size 60% 65%, class:org.gnome.gThumb"
    ];
  };
}
