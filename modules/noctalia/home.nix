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
      "Super, V, exec, pgrep wofi && pkill wofi || cliphist list | wofi --show dmenu --prompt 'Clipboard' | cliphist decode | wl-copy"
      "Ctrl+Super, R, exec, pkill quickshell; sleep 0.2 && noctalia-shell &"
    ];
  };
}
