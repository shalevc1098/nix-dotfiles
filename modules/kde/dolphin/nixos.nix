{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.ffmpegthumbs
    kdePackages.kio-admin
  ];

  # Fix Dolphin's "Open with" menu not opening at all
  environment.pathsToLink = [ "/share" ];

  # Fix Dolphin's "Open with" menu by providing the applications menu file
  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # For cache to rebuild on each rebuild
  system.userActivationScripts.rebuildSycoca = ''
    rm -fv "$HOME/.cache/ksycoca"*
  '';
}
