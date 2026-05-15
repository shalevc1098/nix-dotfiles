{
  hyprLib,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dankmaterialshell.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    enableDynamicTheming = false;
    enableAudioWavelength = false;
    enableCalendarEvents = false;
    quickshell = {
      package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.withModules [
        pkgs.kdePackages.kirigami
        pkgs.kdePackages.qtmultimedia
      ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    on = [
      (hyprLib.mkStartHook [ "dms run &" ])
    ];

    bind = [
      (hyprLib.mkBindExec "SUPER + Super_L" "pgrep quickshell && dms ipc call spotlight toggle || (pgrep wofi && pkill wofi || wofi)")
      (hyprLib.mkBindExec "CTRL + SUPER + R" "pkill quickshell; sleep 0.2 && dms run &")
    ];

    layer_rule = [
      { match = { namespace = "dms:bar"; }; blur = true; ignore_alpha = 0.0; xray = true; }
    ];

    window_rule = [
      { match = { class = "com.danklinux.dms"; }; opacity = "0.86 0.79"; }
    ];
  };

  home.sessionVariables = {
    DMS_HYPRLAND_EXCLUSIVE_FOCUS = 1;
  };
}
