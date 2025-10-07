{ inputs, ... }:
{
  imports = [
    inputs.dankmaterialshell.homeModules.dankMaterialShell.default
    # inputs.niri.homeModules.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableDynamicTheming = false;
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "dms run &"
    ];
    
    bind = [
      "Super, Super_L, exec, pgrep quickshell && dms ipc call spotlight toggle || (pgrep wofi && pkill wofi || wofi)"
      "Ctrl+Super, R, exec, pkill quickshell; sleep 0.2 && dms run &"
    ];
  };
}