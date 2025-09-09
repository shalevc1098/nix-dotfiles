{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lm_sensors
  ];

  programs.coolercontrol.enable = true;
}
