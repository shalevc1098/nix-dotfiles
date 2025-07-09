{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      package = pkgs.steam;

      extraPackages = with pkgs; [
        gamescope
        mangohud
      ];
    };
  };
  hardware.xone.enable = true;
}