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

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^org\\.gnome\\.gThumb$"; }];
      open-floating = true;
      default-column-width.proportion = 0.6;
      default-window-height.proportion = 0.65;
    }
  ];
}
