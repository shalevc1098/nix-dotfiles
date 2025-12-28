{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    anydesk
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class Anydesk, float on"
      "match:class Anydesk, size (monitor_w*0.6) (monitor_h*0.65)"
    ];
  };

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^Anydesk$"; }];
      open-floating = true;
      default-column-width.proportion = 0.6;
      default-window-height.proportion = 0.65;
    }
  ];
}
