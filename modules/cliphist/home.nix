{
  hyprLib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    cliphist
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings = {
    on = [
      (hyprLib.mkStartHook [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ])
    ];

    bind = [
      (hyprLib.mkBindExec "SUPER + V" "dms ipc call clipboard toggle && exit || pgrep wofi && pkill wofi || cliphist list | wofi --show dmenu --prompt 'Clipboard' | cliphist decode | wl-copy")
    ];
  };

  services.wl-clip-persist.enable = true;

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
