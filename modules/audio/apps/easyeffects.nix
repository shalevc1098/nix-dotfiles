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
  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class ^(com.github.wwmm.easyeffects)$, float on"
    "match:class ^(com.github.wwmm.easyeffects)$, size (monitor_w*0.6) (monitor_h*0.7)"
    "match:class ^(com.github.wwmm.easyeffects)$, center on"
  ];
}
