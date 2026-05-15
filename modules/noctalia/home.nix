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

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "sh" "-c" "noctalia-shell &" ]; }
    ];
    binds = {
      "Mod+Space".action.spawn = [ "sh" "-c" "pgrep quickshell && noctalia-shell ipc call launcher toggle || (pgrep wofi && pkill wofi || wofi)" ];
      "Ctrl+Mod+R".action.spawn = [ "sh" "-c" "pkill quickshell; sleep 0.2 && noctalia-shell &" ];
    };
  };
}
