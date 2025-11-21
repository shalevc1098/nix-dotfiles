{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];
}
