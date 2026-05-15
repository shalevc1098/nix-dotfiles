{
  hyprLib,
  pkgs,
  inputs,
  ...
}:
{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # systemd.enable = true;
  };

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "quickshell &" ])
  ];
}
