{
  config,
  inputs,
  pkgs,
  ...
}:
with config.wayland.windowManager.hyprland.settings;
{
  programs.hyprlock = {
    enable = true;
    # package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      background = {
        color = "rgba(25, 20, 20, 1.0)";
      };
    };
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

  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || uwsm app -- hyprlock";
    };
  };
}
