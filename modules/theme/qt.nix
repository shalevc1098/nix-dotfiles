{
  config,
  hyprLib,
  pkgs,
  ...
}:
let
  qtDir = version: "${config.home.profileDirectory}/lib/qt-${version}";
  qt5Dir = qtDir pkgs.libsForQt5.qtbase.version;
  qt6Dir = qtDir "6";
in
{
  home.packages = with pkgs; [
    kdePackages.plasma-integration
    kdePackages.plasma-integration.qt5
    kdePackages.breeze
    libsForQt5.qtstyleplugin-kvantum
    qt6.qtdeclarative
    libsForQt5.qt5ct
    qt6.qt5compat
    qt6.qtwayland
    kdePackages.qtwayland
    kdePackages.kio
  ];

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QML_IMPORT_PATH = "${qt6Dir}/qml";
  };

  wayland.windowManager.hyprland.settings.env = [
    (hyprLib.mkEnv "QT_PLUGIN_PATH" "${qt5Dir}/plugins:${qt6Dir}/plugins")
    (hyprLib.mkEnv "QML2_IMPORT_PATH" "${qt5Dir}/qml:${qt6Dir}/qml")
  ];
}
