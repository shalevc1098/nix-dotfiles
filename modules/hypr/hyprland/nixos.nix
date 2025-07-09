{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  hyprland-patch = pkgs.fetchpatch {
    name = "hyprland-hidpi-xprop.patch";
    url = "https://patch-diff.githubusercontent.com/raw/hyprwm/Hyprland/pull/6446.patch";
    hash = "sha256-OvIU91ag4D/mr6fCfg3xOILi8GdDPpnzz03CsBUzgm0=";
  };
  xwayland-patch = pkgs.fetchpatch {
    name = "xwayland-hidpi-xprop.patch";
    url = "https://aur.archlinux.org/cgit/aur.git/plain/hidpi.patch?h=xorg-xwayland-hidpi-xprop";
    hash = "sha256-e1Yv2s9rDV5L0sVlwbsjmlgzOv8csCrPQ9aZSuZuEDQ=";
  };
  xwayland = pkgs.xwayland.overrideAttrs (previousArgs: {
    patches = [ xwayland-patch ];
    mesonFlags = previousArgs.mesonFlags ++ [
      (lib.mesonBool "xvfb" false)
      (lib.mesonBool "xdmcp" false)
    ];
  });
in
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    package =
      (inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.overrideAttrs {
        patches = [ hyprland-patch ];
      }).override
        {
          inherit xwayland;
        };
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = [ xwayland ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
