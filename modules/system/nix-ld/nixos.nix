{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    curl
    openssl
    qt6.qtbase
    qt6.qtwayland
    wayland
    libxkbcommon
    libGL
    fontconfig
  ];

  environment.variables = {
    LD_LIBRARY_PATH = [
      "/run/opengl-driver/lib"
    ];
  };
}
