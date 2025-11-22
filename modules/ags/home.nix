{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  # pulls in geistmono.nix and fills in the standard args (stdenv, lib, etc.)
  geistMono = pkgs.callPackage ../custom-fonts/geistmono.nix { };
in
{
  imports = [ inputs.ags.homeManagerModules.default ];

  fonts.fontconfig.enable = lib.mkDefault true;
  home.packages = [
    inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.io
    inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.tray
    pkgs.nerd-fonts.jetbrains-mono
    geistMono
    pkgs.libdbusmenu-gtk3
    pkgs.json-glib
    pkgs.gobject-introspection
    pkgs.python3Packages.pygobject3
  ];

  programs.ags = {
    enable = true;

    configDir = null;

    extraPackages = with pkgs; [
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.apps
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.auth
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.bluetooth
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.cava
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.mpris
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.network
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.notifd
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.tray
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.wireplumber # TODO: maybe remove
    ];
  };

  # wayland.windowManager.hyprland.settings = {
  #   # exec-once = [
  #   #   "ags &"
  #   # ];

  #   layerrule = [
  #     "noanim, walker"
  #     "noanim, selection"
  #     "noanim, overview"
  #     "noanim, anyrun"
  #     "noanim, indicator.*"
  #     "noanim, osk"
  #     "noanim, noanim"
  #     "blur, gtk-layer-shell"
  #     "ignorezero, gtk-layer-shell"
  #     "blur, launcher"
  #     "ignorealpha 0.5, launcher"
  #     "blur, notifications"
  #     "ignorealpha 0.69, notifications"
  #     "animation slide left, sideleft.*"
  #     "animation slide right, sideright.*"
  #     "blur, session[0-9]*"
  #     "blur, bar[0-9]*"
  #     "ignorealpha 0.6, bar[0-9]*"
  #     "blur, barcorner.*"
  #     "ignorealpha 0.6, barcorner.*"
  #     "blur, dock[0-9]*"
  #     "ignorealpha 0.6, dock[0-9]*"
  #     "blur, indicator.*"
  #     "ignorealpha 0.6, indicator.*"
  #     "blur, overview[0-9]*"
  #     "ignorealpha 0.6, overview[0-9]*"
  #     "blur, cheatsheet[0-9]*"
  #     "ignorealpha 0.6, cheatsheet[0-9]*"
  #     "blur, sideright[0-9]*"
  #     "ignorealpha 0.6, sideright[0-9]*"
  #     "blur, sideleft[0-9]*"
  #     "ignorealpha 0.6, sideleft[0-9]*"
  #     "blur, indicator.*"
  #     "ignorealpha 0.6, indicator.*"
  #     "blur, osk[0-9]*"
  #     "ignorealpha 0.6, osk[0-9]*"
  #   ];
  # };
}
