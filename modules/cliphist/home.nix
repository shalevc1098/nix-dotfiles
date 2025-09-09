{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cliphist
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
    
    bind = [
      "Super, Super_L, exec, pgrep quickshell && noctalia-shell ipc call launcher toggle || (pgrep wofi && pkill wofi || wofi)"
    ];
  };
}
