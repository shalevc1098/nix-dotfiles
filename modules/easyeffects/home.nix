{
  hyprLib,
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
    on = [
      (hyprLib.mkStartHook [ "easyeffects --gapplication-service" ])
    ];
    window_rule = [
      { match = { class = "com.github.wwmm.easyeffects"; }; float = true; size = [ "(monitor_w*0.6)" "(monitor_h*0.7)" ]; center = true; }
    ];
  };
}
