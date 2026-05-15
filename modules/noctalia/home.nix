{ hyprLib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.noctalia.packages.${system}.default
    inputs.quickshell.packages.${system}.default
  ];

  wayland.windowManager.hyprland.settings = {
    on = [
      (hyprLib.mkStartHook [ "noctalia-shell &" ])
    ];

    bind = [
      (hyprLib.mkBindExec "SUPER + Super_L" "pgrep quickshell && noctalia-shell ipc call launcher toggle || (pgrep wofi && pkill wofi || wofi)")
      (hyprLib.mkBindExec "CTRL + SUPER + R" "pkill quickshell; sleep 0.2 && noctalia-shell &")
    ];
  };
}
