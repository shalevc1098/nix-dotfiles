{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    cliphist
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];

    bind = [
      "Super, V, exec, dms ipc call clipboard toggle && exit || pgrep wofi && pkill wofi || cliphist list | wofi --show dmenu --prompt 'Clipboard' | cliphist decode | wl-copy"
    ];
  };

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "wl-paste" "--type" "text" "--watch" "cliphist" "store" ]; }
      { command = [ "wl-paste" "--type" "image" "--watch" "cliphist" "store" ]; }
    ];
    binds = {
      "Mod+V".action.spawn = [ "sh" "-c" "dms ipc call clipboard toggle && exit || pgrep wofi && pkill wofi || cliphist list | wofi --show dmenu --prompt 'Clipboard' | cliphist decode | wl-copy" ];
    };
  };
}
