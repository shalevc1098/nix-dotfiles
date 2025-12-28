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
      "match:class ^(zoom)$, no_blur on"
      "match:class ^(zoom)$, opacity 1.0 1.0"
    ];
  };

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^zoom$"; }];
      open-floating = true;
    }
  ];
}
