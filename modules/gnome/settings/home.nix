{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gsettings-desktop-schemas
  ];
}
