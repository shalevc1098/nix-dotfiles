{
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        ps.libsecret
        ps.gnome-keyring
        ps.dbus
        ps.dotnet-sdk
      ]
    );
  };

  # xdg.mimeApps = {
  #   associations = {
  #     added = {
  #       "x-scheme-handler/vscode" = [ "code-url-handler.desktop" ];
  #     };
  #   };
  #   defaultApplications = {
  #     "x-scheme-handler/vscode" = [ "code-url-handler.desktop" ];
  #   };
  # };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, C, exec, uwsm app -- code"
    ];
  };
}
