{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    easyeffects
  ];

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "easyeffects" "--gapplication-service" ]; }
    ];
    window-rules = [
      {
        matches = [{ app-id = "^com\\.github\\.wwmm\\.easyeffects$"; }];
        open-floating = true;
        default-column-width.proportion = 0.6;
        default-window-height.proportion = 0.7;
      }
    ];
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "easyeffects --gapplication-service"
    ];
    windowrule = [
      "match:class com.github.wwmm.easyeffects, float on"
      "match:class com.github.wwmm.easyeffects, size (monitor_w*0.6) (monitor_h*0.7)"
      "match:class com.github.wwmm.easyeffects, center on"
    ];
  };
}
