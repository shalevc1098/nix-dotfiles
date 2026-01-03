{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ((kdePackages.callPackage "${pkgs.path}/pkgs/applications/misc/lyx" {
      inherit (kdePackages) qtbase qtsvg;
      mkDerivation = stdenv.mkDerivation;
    }).overrideAttrs (oldAttrs: {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ kdePackages.wrapQtAppsHook ];
      configureFlags = [ "--enable-qt6" ] ++ (builtins.filter (flag: flag != "--enable-qt5") oldAttrs.configureFlags);

      # Patch Qt6 incompatibility in GuiSymbols.cpp
      postPatch = (oldAttrs.postPatch or "") + ''
        substituteInPlace src/frontends/qt/GuiSymbols.cpp \
          --replace-fail '.arg(QString("%1").arg(c, 0, 16).toUpper())' '.arg(QString::number(static_cast<uint>(c), 16).toUpper())'
      '';

      # Skip tests - they have linking issues with Qt6
      doCheck = false;
    }))

    (texlive.combine {
      inherit (texlive)
        scheme-full
        collection-xetex
        collection-langarabic
        ;
    })

    culmus
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class lyx, opacity 0.86 0.79"
    ];
  };
}
