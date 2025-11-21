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
}
