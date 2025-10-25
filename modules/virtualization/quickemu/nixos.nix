{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = [
    inputs.quickemu.packages.${pkgs.system}.default
  ];
}
