{
  config,
  hostMonitors,
  hyprLib,
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
    configType = "lua";
    # set the flake package
    package = null;
    portalPackage = null;

    settings = import ./config {
      inherit lib hyprLib hostMonitors;
    };
  };

  home.file.".config/hypr/shaders" = {
    source = builtins.toString ./shaders;
    recursive = true;
  };

  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  systemd.user.sessionVariables = config.home.sessionVariables;
}
