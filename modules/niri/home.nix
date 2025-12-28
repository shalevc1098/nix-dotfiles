{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    brightnessctl
    ddcutil
    dart-sass
    wl-clipboard
    playerctl
    xwayland-satellite
    inputs.niri-float-sticky.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.playerctld.enable = true;

  programs.niri = {
    settings = lib.mkMerge [
      (import ./config { inherit lib; })
      {
        spawn-at-startup = [
          { command = [ "niri-float-sticky" ]; }
        ];
      }
    ];
  };

  # Wrapper config that includes matugen colors
  xdg.configFile."niri/wrapper.kdl".text = ''
    include optional=true "colors.kdl"
    include "config.kdl"
  '';

  home.sessionVariables = {
    NIRI_CONFIG = "${config.home.homeDirectory}/.config/niri/wrapper.kdl";
  };

  systemd.user.sessionVariables = config.home.sessionVariables;
}
