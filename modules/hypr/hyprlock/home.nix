{
  config,
  hyprLib,
  inputs,
  pkgs,
  lib,
  ...
}:

{
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
  };

  # xdg.configFile."hypr/hyprlock.conf".source = builtins.toString ./hyprlock.conf;

  wayland.windowManager.hyprland.settings.bind = [
    (hyprLib.mkBindExec "SUPER + L" "hyprlock")
  ];

  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";
    };
  };
}
