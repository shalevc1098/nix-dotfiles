{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    qemu
  ];

  boot.extraModprobeConfig = "options kvm ignore_msrs=1";
}
