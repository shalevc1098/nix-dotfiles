{ pkgs, ... }:
{
  home.packages = with pkgs; [
    scanmem
  ];
}
