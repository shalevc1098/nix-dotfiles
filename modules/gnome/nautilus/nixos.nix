{ pkgs, ... }:
{
  # TODO: split
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    nautilus
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };
}
