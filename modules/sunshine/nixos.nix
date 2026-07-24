{ pkgs, ... }:
{
  services.sunshine = {
    enable = true;
    autoStart = false;
    openFirewall = true;
    capSysAdmin = true;
    package = pkgs.sunshine.override { cudaSupport = true; };
  };

  services.udev.extraRules = ''
    KERNEL=="uhid", GROUP="input", MODE="0660"
  '';
}
