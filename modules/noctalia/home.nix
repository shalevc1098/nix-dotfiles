{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.noctalia.packages.${system}.default
    inputs.quickshell.packages.${system}.default
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "noctalia-shell &"
    ];
    
    bind = [
      "Super, Super_L, exec, pgrep quickshell && noctalia-shell ipc call launcher toggle || (pgrep wofi && pkill wofi || wofi)"
      "Ctrl+Super, R, exec, pkill quickshell; sleep 0.2 && noctalia-shell &"
    ];
  };
}
