{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  lock_cmd = "pidof hyprlock || uwsm app -- hyprlock";
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = lock_cmd;
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 180;
          on-timeout = lock_cmd;
        }
        {
          timeout = 240;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
