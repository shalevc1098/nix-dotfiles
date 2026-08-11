{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;

    # package = pkgs.hyprland;
    # portalPackage = pkgs.xdg-desktop-portal-hyprland;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = [ pkgs.xwayland ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # the cap_sys_nice wrapper's capset() fails with EPERM in-session
  security.wrappers.Hyprland.enable = lib.mkForce false;
}
