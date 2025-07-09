{
  pkgs,
  ...
}:
{
  # Install EasyEffects but don't use the systemd service (causes Wayland issues)
  home.packages = with pkgs; [
    easyeffects
  ];

  # Start EasyEffects manually via Hyprland exec-once
  wayland.windowManager.hyprland.settings.exec-once = [
    "easyeffects --gapplication-service"
  ];
}
