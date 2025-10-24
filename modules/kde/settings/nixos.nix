{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.systemsettings
    kdePackages.qtpositioning
    kdePackages.knewstuff
    kdePackages.kquickcharts
  ];
}
