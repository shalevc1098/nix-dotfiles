{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # imports = [ ./hidpi-xprop.nix ];

  home.packages = with pkgs; [
    brightnessctl
    ddcutil
    dart-sass
    wl-clipboard
    playerctl
  ];

  services.playerctld.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = null;
    portalPackage = null;

    settings = import ./config {
      inherit lib;
    };
  };

  home.file.".config/hypr/shaders" = {
    source = builtins.toString ./shaders;
    recursive = true;
  };

  systemd.user.sessionVariables = config.home.sessionVariables;
}
