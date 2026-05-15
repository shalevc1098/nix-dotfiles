{
  hyprLib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    easyeffects
  ];

  wayland.windowManager.hyprland.settings = {
    on = [
      (hyprLib.mkStartHook [ "easyeffects --gapplication-service" ])
    ];
    window_rule = [
      { match = { class = "com.github.wwmm.easyeffects"; }; float = true; size = [ "(monitor_w*0.6)" "(monitor_h*0.7)" ]; center = true; }
    ];
  };
}
