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
    kdePackages.plasma-workspace
  ];

  # Fix Dolphin's "Open with" menu by providing the applications menu file
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
