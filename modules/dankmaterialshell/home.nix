{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dankmaterialshell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableDynamicTheming = false;
    enableAudioWavelength = false;
    quickshell = {
      package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.withModules [
        pkgs.kdePackages.kirigami
        pkgs.kdePackages.qtmultimedia
      ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "dms run &"
    ];

    bind = [
      "Super, Super_L, exec, pgrep quickshell && dms ipc call spotlight toggle || (pgrep wofi && pkill wofi || wofi)"
      "Ctrl+Super, R, exec, pkill quickshell; sleep 0.2 && dms run &"
    ];

    layerrule = [
      "match:namespace dms:bar, blur on"
      "match:namespace dms:bar, ignore_alpha 0.0"
      "match:namespace dms:bar, xray on"
    ];
  };

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "sh" "-c" "dms run &" ]; }
    ];
    binds = {
      "Mod+Space".action.spawn = [ "sh" "-c" "pgrep quickshell && dms ipc call spotlight toggle || (pgrep wofi && pkill wofi || wofi)" ];
      "Ctrl+Mod+R".action.spawn = [ "sh" "-c" "pkill quickshell; sleep 0.2 && dms run &" ];
    };
  };
}
