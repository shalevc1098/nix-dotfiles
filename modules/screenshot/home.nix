{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grimblast
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "Super+Shift, S, exec, grimblast --freeze copy area" # Region Screenshot (freeze screen while selecting)
    ];
    bindl = [
      ", Print, exec, grimblast copy output" # Fullscreen Screenshot
    ];
  };
}
