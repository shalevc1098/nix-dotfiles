{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nautilus
    nautilus-open-any-terminal
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, E, exec, uwsm app -- nautilus --new-window"
    ];
  };
}
