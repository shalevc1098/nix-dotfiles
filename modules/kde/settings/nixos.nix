{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.systemsettings
  ];
}