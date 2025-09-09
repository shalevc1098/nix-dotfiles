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

  # Window rule for EasyEffects
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, class:^(com.github.wwmm.easyeffects)$"
    "size 60% 70%, class:^(com.github.wwmm.easyeffects)$"
    "center, class:^(com.github.wwmm.easyeffects)$"
  ];
}
