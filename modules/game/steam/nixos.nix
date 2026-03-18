{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  steam-config = import "${inputs.mysecrets}/steam-config.nix";
in
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

    presence = {
      enable = true;
      steamApiKey = steam-config.apiKey;
      userIds = [ steam-config.userId ];
    };
  };

  # hardware.steam-hardware.enable = lib.mkDefault false;
}
