{ inputs, ... }:
{
  imports = [
    inputs.dankmaterialshell.homeModules.dankMaterialShell
    inputs.niri.homeModules.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableDynamicTheming = true;
  };
}