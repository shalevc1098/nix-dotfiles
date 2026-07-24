{
  pkgs,
  ...
}:
let
  ppsspp-wayland = pkgs.symlinkJoin {
    name = "ppsspp-wayland";
    paths = [ pkgs.ppsspp ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/ppsspp --set SDL_VIDEODRIVER wayland

      rm $out/share/applications/ppsspp.desktop
      sed '/^\[Desktop Entry\]/a StartupWMClass=PPSSPPSDL' \
        ${pkgs.ppsspp}/share/applications/ppsspp.desktop \
        > $out/share/applications/ppsspp.desktop
    '';
  };
in
{
  home.packages = [
    ppsspp-wayland
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "PPSSPPSDL"; }; float = true; size = [ "(monitor_w*0.6)" "(monitor_h*0.65)" ]; center = true; }
  ];
}
