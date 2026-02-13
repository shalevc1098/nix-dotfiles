{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];

  services.hardware.openrgb.enable = true;

  systemd.services.openrgb.serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
}
