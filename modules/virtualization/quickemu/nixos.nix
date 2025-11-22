{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = [
    inputs.quickemu.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
