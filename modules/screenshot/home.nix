{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grimblast
    swappy
  ];

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures
  '';

  wayland.windowManager.hyprland.settings = {
    bind = [
      "Super+Shift, S, exec, grimblast --freeze copy area; pkill -9 hyprpicker" # Region Screenshot (freeze screen while selecting)
      "Super+Shift+Ctrl, S, exec, grimblast --freeze save area - | swappy -f -; pkill -9 hyprpicker" # Region Screenshot with editor
    ];
    bindl = [
      ", Print, exec, grimblast copy output" # Fullscreen Screenshot
    ];
  };
}
