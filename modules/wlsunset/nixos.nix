{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wlsunset
  ];
}
