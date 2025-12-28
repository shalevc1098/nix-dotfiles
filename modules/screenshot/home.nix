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
      "Alt, Print, exec, grimblast copy window" # Window Screenshot
    ];
    bindl = [
      ", Print, exec, grimblast copy output" # Fullscreen Screenshot
    ];
  };

  programs.niri.settings.binds = {
    "Mod+Shift+S".action.screenshot = {};
    "Print".action.screenshot-screen = {};
    "Alt+Print".action.screenshot-window = {};
    "Mod+Ctrl+Shift+S".action.spawn = [ "sh" "-c" "niri msg action screenshot && sleep 0.1 && swappy -f \"$(ls -t ~/Pictures/Screenshots/*.png | head -1)\"" ];
  };
}
