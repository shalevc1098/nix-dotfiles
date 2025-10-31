{ pkgs, ... }:

{
  programs.zoom-us = {
    enable = true;
    package = pkgs.zoom-us.override {
      pulseaudioSupport = true;
    };
  };
}
