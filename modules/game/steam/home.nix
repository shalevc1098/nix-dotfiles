{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonplus
    protonup-qt
  ];

  home.sessionVariables = {
    STEAM_DISABLE_WAYLAND = 1;
  };

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "steam"; }; float = true; }
    { match = { class = "steam"; title = "^Steam$"; }; size = [ "(monitor_w*0.6)" "(monitor_h*0.65)" ]; center = true; }
    { match = { class = "steam_app_.*"; }; center = true; }
  ];
}
