{ config, hyprLib, pkgs, ... }:
{
  xresources.properties = {
    "Xft.dpi" = 144;
    "Xft.antialias" = 1;
    "Xft.hinting" = 1;
    "Xft.hintstyle" = "hintslight";
    "Xft.rgba" = "rgb";
    "Xft.lcdfilter" = "lcddefault";
  };

  home.packages = [ pkgs.xorg.xrdb ];

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "xrdb -merge ${config.home.homeDirectory}/.Xresources" ])
  ];
}
