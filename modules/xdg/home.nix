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
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      configPackages = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}
