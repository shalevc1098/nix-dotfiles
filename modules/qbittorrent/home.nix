{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    qbittorrent
  ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class org.qbittorrent.qBittorrent, opacity 0.86 0.79"
  ];
}
