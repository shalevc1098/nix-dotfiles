{ hyprLib, pkgs, ... }:
{
  home.packages = with pkgs; [
    grimblast
    swappy
  ];

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures
  '';

  wayland.windowManager.hyprland.settings.bind = [
    (hyprLib.mkBindExec "SUPER + SHIFT + S" "grimblast --freeze copy area; pkill -9 hyprpicker") # Region (freeze + copy)
    (hyprLib.mkBindExec "SUPER + SHIFT + CTRL + S" "grimblast --freeze save area - | swappy -f -; pkill -9 hyprpicker") # Region (editor)
    (hyprLib.mkBindExec "ALT + Print" "grimblast copy window") # Window screenshot
    (hyprLib.mkBindExecFlags "Print" "grimblast copy output" { locked = true; }) # Fullscreen (was bindl)
  ];

  programs.niri.settings.binds = {
    "Mod+Shift+S".action.screenshot = {};
    "Print".action.screenshot-screen = {};
    "Alt+Print".action.screenshot-window = {};
    "Mod+Ctrl+Shift+S".action.spawn = [ "sh" "-c" "niri msg action screenshot && sleep 0.1 && swappy -f \"$(ls -t ~/Pictures/Screenshots/*.png | head -1)\"" ];
  };
}
