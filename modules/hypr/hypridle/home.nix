{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  lock_cmd = "pidof hyprlock || uwsm app -- hyprlock";
  screen_off_cmd = "pidof hyprlock && hyprctl dispatch dpms off";
  screen_on_cmd = "hyprctl dispatch dpms on";
  lock_timeout = 300;
  screen_timeout = 60;
in
{
  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      general = {
        before_sleep_cmd = lock_cmd;
        after_sleep_cmd = screen_on_cmd;
      };

      listener = [
        {
          timeout = lock_timeout;
          on-timeout = lock_cmd;
        }
        {
          timeout = lock_timeout + screen_timeout;
          on-timeout = screen_off_cmd;
          on-resume = screen_on_cmd;
        }
        {
          timeout = screen_timeout;
          on-timeout = screen_off_cmd;
          on-resume = screen_on_cmd;
        }
      ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hypridle"
    ];
  };
}
