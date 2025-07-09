{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
  };

  home.packages = with pkgs; [
    fish
    firefox
  ];
}
