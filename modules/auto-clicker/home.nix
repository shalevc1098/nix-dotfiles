{
  config,
  pkgs,
  ...
}:
let
  autoclickerPython = pkgs.python313.withPackages (
    ps: with ps; [
      pyqt6
      pynput
    ]
  );
in
{
  # home.file.".local/bin/autoclicker" = {
  #   executable = true;
  #   text = ''
  #     #!/run/current-system/sw/bin/bash

  #     show_dialog() {
  #       if pgrep -f "autoclicker-worker" > /dev/null; then
  #         pkill -f "autoclicker-worker"
  #         ${pkgs.zenity}/bin/zenity --info --title="Auto Clicker" --text="Autoclicker stopped" --timeout=2 2>/dev/null
  #         exit 0
  #       fi

  #       INTERVAL=$(${pkgs.zenity}/bin/zenity --entry \
  #         --title="Auto Clicker" \
  #         --text="Enter interval in ms:" \
  #         --entry-text="100" 2>/dev/null)

  #       if [ -z "$INTERVAL" ]; then
  #         exit 0
  #       fi

  #       (exec -a autoclicker-worker bash -c "
  #         while true; do
  #           ydotool click 0xC0 2>/dev/null
  #           ${pkgs.python3}/bin/python3 -c 'import time; time.sleep($INTERVAL / 1000)' 2>/dev/null
  #         done
  #       ") &

  #       ${pkgs.zenity}/bin/zenity --info --title="Auto Clicker" --text="Autoclicker started with ''${INTERVAL}ms interval" --timeout=2 2>/dev/null
  #     }

  #     stop_autoclicker() {
  #       if pgrep -f "autoclicker-worker" > /dev/null; then
  #         pkill -f "autoclicker-worker"
  #         echo "Stopped"
  #       else
  #         echo "Not running"
  #       fi
  #     }

  #     status_autoclicker() {
  #       if pgrep -f "autoclicker-worker" > /dev/null; then
  #         echo "Running"
  #       else
  #         echo "Not running"
  #       fi
  #     }

  #     case "$1" in
  #       -s|--stop) stop_autoclicker ;;
  #       -t|--status) status_autoclicker ;;
  #       *) show_dialog ;;
  #     esac
  #   '';
  # };

  home.file.".local/bin/autoclicker" = {
    executable = true;
    text = ''
      #!${autoclickerPython}/bin/python3
    ''
    + builtins.readFile ./autoclicker.py;
  };

  xdg.desktopEntries.autoclicker = {
    name = "OP Auto Clicker";
    comment = "A versatile way to automate mouse clicks";
    exec = ".local/bin/autoclicker";
    icon = ./icon.png;
    terminal = false;
    categories = [ "Utility" ];
  };

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:title ^(autoclicker-pick)$, no_blur on"
    ];
  };
}
