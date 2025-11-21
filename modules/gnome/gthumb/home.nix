{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gthumb
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class org.gnome.gThumb, float on"
      "match:class org.gnome.gThumb, size (monitor_w*0.6) (monitor_h*0.65)"
    ];
  };
}
