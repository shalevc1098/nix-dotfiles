{
  config,
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

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "sleep 2; uwsm app -- hyprlock || uwsm stop" # autologin into hyprlock
    ];
    bind = [
      "$mainMod, L, exec, uwsm app -- hyprlock"
    ];
  };

  programs.niri.settings.binds = {
    "Mod+L".action.spawn = [ "hyprlock" ];
  };

  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || uwsm app -- hyprlock";
    };
  };
}
