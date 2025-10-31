{
  config,
  pkgs,
  ...
}:
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
    libsForQt5.kio
  ];

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QML_IMPORT_PATH = "${config.home.profileDirectory}/lib/qt-6/qml";
  };
}
