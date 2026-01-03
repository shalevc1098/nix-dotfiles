{
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

  programs.niri.settings.spawn-at-startup = [
    { command = [ "quickshell" ]; }
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "QSG_RHI_BACKEND=vulkan quickshell &"
      "quickshell &"
    ];
  };
}
