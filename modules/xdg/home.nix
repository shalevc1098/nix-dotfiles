{ lib, pkgs, ... }:
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = lib.mkForce true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}
