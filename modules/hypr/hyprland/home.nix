{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hidpi-xprop.nix ];

  home.packages = with pkgs; [
    brightnessctl
    ddcutil
    dart-sass
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = null;
    portalPackage = null;

    settings = import ./config {
      inherit lib;
    };

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
    ];
  };

  home.file.".config/hypr/shaders" = {
    source = builtins.toString ./shaders;
    recursive = true;
  };

  systemd.user.sessionVariables = config.home.sessionVariables;
}
