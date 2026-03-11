{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    (pkgs.quickemu.override { qemu = pkgs.qemu; })
  ];
}
