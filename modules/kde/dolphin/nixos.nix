{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.kdialog
    kdePackages.kconfig
    kdePackages.kservice
    kdePackages.kded
    kdePackages.kio-admin
    kdePackages.plasma-desktop
    kdePackages.plasma-workspace
    qt6.full
  ];

  services.desktopManager.plasma6.enable = true;

  # Fix Dolphin's "Open with" menu by providing the applications menu file
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
