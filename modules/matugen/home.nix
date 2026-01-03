{
  config,
  inputs,
  pkgs,
  ...
}:
let
  matugen-git = inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [
    matugen-git
    pkgs.fatrace
    pkgs.zenity
  ];

  home.file.".local/bin/wal" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -eu

      STATE_FILE="$HOME/.local/state/wallpaper.txt"
      FALLBACK_WALL="${./wallpaper.jpg}"

      if [ "''${1:-}" == "--boot" ]; then
        if [ -f "$STATE_FILE" ]; then
          selected=$(cat "$STATE_FILE")
        else
          selected="$FALLBACK_WALL"
        fi
        
        exec "$0" "''${selected}"
      fi

      if [ $# -eq 0 ]; then
        start_dir="$HOME/Pictures/Wallpapers"
        [ -d "$start_dir" ] || start_dir="$HOME"
        selected=$(${pkgs.zenity}/bin/zenity --file-selection --title="Select Wallpaper" --filename="$start_dir/" --file-filter="Images | *.png *.jpg *.jpeg *.webp *.bmp *.gif" --file-filter="All Files | *")
        if [ -n "''${selected}" ]; then
          exec "$0" "''${selected}"
        else
          exit 1
        fi
      fi

      wallpaper=$(${pkgs.coreutils}/bin/readlink -f "$1")
      ${matugen-git}/bin/matugen image "''${wallpaper}" 1>/dev/null -t scheme-tonal-spot

      if command -v kde-material-you-colors >/dev/null 2>&1; then
        kde-material-you-colors >/dev/null 2>&1 &
      fi
    '';
  };

  xdg.configFile."matugen/config.toml".text = ''
    [config.wallpaper]
    command = "${pkgs.swww}/bin/swww"
    arguments = ["img", "--transition-step", "100", "--transition-fps", "120", "--transition-type", "grow", "--transition-angle", "30", "--transition-duration", "1"]

    [templates.ags]
    input_path = "${./templates/ags/colors.scss}"
    output_path = "~/.config/ags/styles/colors.scss"

    [templates.dankmaterialshell]
    input_path = "${./templates/dankmaterialshell/colors.json}"
    output_path = "~/.config/DankMaterialShell/colors.json"

    [templates.discord_midnight]
    input_path = "${./templates/discord/midnight.css}"
    output_path = "~/.config/vesktop/themes/midnight-discord.css"

    [templates.gtk3]
    input_path = "${./templates/gtk/colors.css}"
    output_path = "~/.config/gtk-3.0/colors.css"

    [templates.gtk4]
    input_path = "${./templates/gtk/colors.css}"
    output_path = "~/.config/gtk-4.0/colors.css"

    [templates.fish]
    input_path = "${./templates/fish/colors.fish}"
    output_path = "~/.config/fish/colors.fish"

    [templates.foot]
    input_path = "${./templates/foot/colors.ini}"
    output_path = "~/.config/foot/colors.ini"

    [templates.fuzzel]
    input_path = "${./templates/fuzzel/fuzzel_theme.ini}"
    output_path = "~/.config/fuzzel/fuzzel_theme.ini"

    [templates.hyprland]
    input_path = '${./templates/hyprland/colors.conf}'
    output_path = '~/.config/hypr/colors.conf'
    post_hook = 'hyprctl reload'

    [templates.hyprlock]
    input_path = "${./templates/hyprland/hyprlock.conf}"
    output_path = '~/.config/hypr/hyprlock.conf'

    [templates.kitty]
    input_path = "${./templates/kitty/colors.conf}"
    output_path = "~/.config/kitty/colors.conf"

    [templates.niri]
    input_path = "${./templates/niri/colors.kdl}"
    output_path = "~/.config/niri/colors.kdl"
    post_hook = "niri msg action load-config-file || true"

    [templates.noctalia]
    input_path = "${./templates/noctalia/colors.json}"
    output_path = "~/.config/noctalia/colors.json"

    [templates.pywalfox]
    input_path = "${./templates/pywalfox/colors.json}"
    output_path = "~/.cache/wal/colors.json"

    [templates.quickshell]
    input_path = "${./templates/quickshell/colors.json}"
    output_path = "~/.local/quickshell/colors.json"

    [templates.spicetify]
    input_path = "${./templates/spicetify/color.ini}"
    output_path = '~/.config/spicetify/Themes/MaterialYou/color.ini'

    [templates.wallpaper]
    input_path = "${./templates/wallpaper.txt}"
    output_path = "~/.local/state/wallpaper.txt"

    [templates.waybar]
    input_path = "${./templates/waybar/colors.css}"
    output_path = "~/.config/waybar/colors.css"
  '';

  wayland.windowManager.hyprland.settings = {
    bind = [
      "Ctrl+Super, T, exec, ~/.local/bin/wal"
    ];

    windowrule = [
      "match:title ^(Select Wallpaper)(.*)$, float on"
      "match:title ^(Select Wallpaper)(.*)$, center on"
    ];

    exec-once = [
      "sleep 0.5; ~/.local/bin/wal --boot"
    ];
  };

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "sh" "-c" "sleep 0.5; ~/.local/bin/wal --boot" ]; }
    ];
    binds = {
      "Mod+Ctrl+T".action.spawn = [ "sh" "-c" "~/.local/bin/wal" ];
    };
  };
}
