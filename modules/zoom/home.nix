{
  pkgs,
  ...
}:
{
  home.packages = [
    (pkgs.writeShellScriptBin "zoom" ''
      exec ${pkgs.coreutils}/bin/env -u QML2_IMPORT_PATH /run/current-system/sw/bin/zoom "$@"
    '')
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class ^(zoom)$, float on"
    ];
  };
}
