{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    qbittorrent
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "org.qbittorrent.qBittorrent"; }; opacity = "0.86 0.79"; }
  ];
}
