{
  lib,
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    extraPackages = with pkgs; [
      gamescope
      mangohud
    ];
  };

  # hardware.steam-hardware.enable = lib.mkDefault false;
}
