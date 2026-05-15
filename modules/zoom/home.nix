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

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "zoom"; }; float = true; no_blur = true; opacity = "1.0 1.0"; }
  ];

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^zoom$"; }];
      open-floating = true;
    }
  ];
}
