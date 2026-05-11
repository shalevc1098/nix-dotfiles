{ pkgs, ... }:
{
  home.packages = with pkgs.kdePackages; [
    kwallet
    kwallet-pam
    kwalletmanager
  ];
}
