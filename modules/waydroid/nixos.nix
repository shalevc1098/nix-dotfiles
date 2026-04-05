{ pkgs, ... }:

{
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
  networking.nftables.enable = true;
  environment.systemPackages = [ pkgs.android-tools ];
}
