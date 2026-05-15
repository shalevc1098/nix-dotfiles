{
  hyprLib,
  pkgs,
  ...
}:
let
  dotnet-combined = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnet-sdk_8
    pkgs.dotnet-sdk_10
  ];
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        ps.libsecret
        ps.gnome-keyring
        ps.dbus
        dotnet-combined
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

  wayland.windowManager.hyprland.settings.bind = [
    (hyprLib.mkBindExec "SUPER + C" "uwsm app -- code")
  ];

  programs.niri.settings.binds = {
    "Mod+C".action.spawn = [ "code" ];
  };
}
