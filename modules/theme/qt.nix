{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # plasma-integration not needed for non-KDE environments
    libsForQt5.qtstyleplugin-kvantum
    qt6.qtdeclarative
    libsForQt5.qt5ct
    qt6.qt5compat
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "kvantum";
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QML_IMPORT_PATH = "${config.home.profileDirectory}/lib/qt-6/qml";
  };
}
