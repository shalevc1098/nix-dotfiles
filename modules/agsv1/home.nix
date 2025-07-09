{ inputs, pkgs, ... }:
let
  pythonAgs = pkgs.python3.withPackages (ps: with ps; [
    build
    pillow
    setuptools-scm
    wheel
    pywayland
    psutil
    materialyoucolor
    libsass
    material-color-utilities
    setproctitle
    numpy
    cffi
    packaging
    pycparser
    pyproject-hooks
    pywal
  ]);
  pythonAgsBin = pkgs.writeShellScriptBin "python-agsv1" ''
    exec ${pythonAgs}/bin/python3 "$@"
  '';
in
{
  imports = [ inputs.agsv1.homeManagerModules.default ];

  home.packages = with pkgs; [
    pythonAgs
    pythonAgsBin
    python313Packages.kde-material-you-colors
  ];

  programs.ags = {
    enable = true;
    configDir = ./ags;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk_6_0
      accountsservice
    ];
  };

  wayland.windowManager.hyprland.settings = {
    # exec-once = [
    #   "ags &"
    # ];

    layerrule = [
      "noanim, walker"
      "noanim, selection"
      "noanim, overview"
      "noanim, anyrun"
      "noanim, indicator.*"
      "noanim, osk"
      "noanim, noanim"
      "blur, gtk-layer-shell"
      "ignorezero, gtk-layer-shell"
      "blur, launcher"
      "ignorealpha 0.5, launcher"
      "blur, notifications"
      "ignorealpha 0.69, notifications"
      "animation slide left, sideleft.*"
      "animation slide right, sideright.*"
      "blur, session[0-9]*"
      "blur, bar[0-9]*"
      "ignorealpha 0.6, bar[0-9]*"
      "blur, barcorner.*"
      "ignorealpha 0.6, barcorner.*"
      "blur, dock[0-9]*"
      "ignorealpha 0.6, dock[0-9]*"
      "blur, indicator.*"
      "ignorealpha 0.6, indicator.*"
      "blur, overview[0-9]*"
      "ignorealpha 0.6, overview[0-9]*"
      "blur, cheatsheet[0-9]*"
      "ignorealpha 0.6, cheatsheet[0-9]*"
      "blur, sideright[0-9]*"
      "ignorealpha 0.6, sideright[0-9]*"
      "blur, sideleft[0-9]*"
      "ignorealpha 0.6, sideleft[0-9]*"
      "blur, indicator.*"
      "ignorealpha 0.6, indicator.*"
      "blur, osk[0-9]*"
      "ignorealpha 0.6, osk[0-9]*"
    ];
  };
}
