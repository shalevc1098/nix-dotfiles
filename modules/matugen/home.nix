{
  config,
  hyprLib,
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
      mode=$(cat "$HOME/.local/state/theme-mode.txt" 2>/dev/null || echo dark)
      ${matugen-git}/bin/matugen image "''${wallpaper}" 1>/dev/null -t scheme-tonal-spot --source-color-index 0 -m "''${mode}"

      if command -v kde-material-you-colors >/dev/null 2>&1; then
        source_color_file="$HOME/.local/state/matugen-source-color.txt"
        if [ -f "$source_color_file" ]; then
          source_color=$(tr -d '[:space:]' < "$source_color_file")
          kde-material-you-colors --color "''${source_color}" >/dev/null 2>&1 &
        else
          kde-material-you-colors >/dev/null 2>&1 &
        fi
      fi
    '';
  };

  home.file.".local/bin/theme" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -u

      STATE="$HOME/.local/state/theme-mode.txt"
      cur=$(cat "$STATE" 2>/dev/null || echo dark)

      case "''${1:-toggle}" in
        light|dark) mode="$1" ;;
        toggle) [ "$cur" = dark ] && mode=light || mode=dark ;;
        *) echo "usage: theme [light|dark|toggle]"; exit 1 ;;
      esac

      mkdir -p "$(dirname "$STATE")"
      echo "$mode" > "$STATE"

      wallpaper=$(cat "$HOME/.local/state/wallpaper.txt" 2>/dev/null || echo "${./wallpaper.jpg}")
      ${matugen-git}/bin/matugen image "$wallpaper" -t scheme-tonal-spot --source-color-index 0 -m "$mode" >/dev/null

      gsettings set org.gnome.desktop.interface color-scheme "prefer-$mode" || true
      if [ "$mode" = light ]; then
        gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3 || true
        plasma-apply-colorscheme MaterialYouLight >/dev/null 2>&1 || true
      else
        gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark || true
        plasma-apply-colorscheme MaterialYouDark >/dev/null 2>&1 || true
      fi

      echo "theme: $mode"
    '';
  };

  xdg.configFile."matugen/config.toml".text = ''
    [config.wallpaper]
    command = "${pkgs.awww}/bin/awww"
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
    post_hook = "fish -c 'set -U __matugen_theme (random)' || true"

    [templates.foot]
    input_path = "${./templates/foot/colors.ini}"
    output_path = "~/.config/foot/colors.ini"

    [templates.fuzzel]
    input_path = "${./templates/fuzzel/fuzzel_theme.ini}"
    output_path = "~/.config/fuzzel/fuzzel_theme.ini"

    [templates.hyprland]
    input_path = '${./templates/hyprland/colors.lua}'
    output_path = '~/.config/hypr/colors.lua'
    post_hook = 'hyprctl reload'

    [templates.hyprlock]
    input_path = "${./templates/hyprland/hyprlock.conf}"
    output_path = '~/.config/hypr/hyprlock.conf'

    [templates.kitty]
    input_path = "${./templates/kitty/colors.conf}"
    output_path = "~/.config/kitty/colors.conf"
    post_hook = "pkill -USR1 kitty || true"

    [templates.noctalia]
    input_path = "${./templates/noctalia/colors.json}"
    output_path = "~/.config/noctalia/colors.json"

    [templates.pywalfox]
    input_path = "${./templates/pywalfox/colors.json}"
    output_path = "~/.cache/wal/colors.json"
    post_hook = "pywalfox --profile-path ${config.xdg.configHome}/mozilla/firefox $(cat ~/.local/state/theme-mode.txt 2>/dev/null || echo dark) || true; pywalfox --profile-path ${config.xdg.configHome}/mozilla/firefox update || true"

    [templates.quickshell]
    input_path = "${./templates/quickshell/colors.json}"
    output_path = "~/.local/quickshell/colors.json"

    [templates.source_color]
    input_path = "${./templates/source-color.txt}"
    output_path = "~/.local/state/matugen-source-color.txt"

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

  wayland.windowManager.hyprland.extraConfig = ''
    pcall(dofile, os.getenv("HOME") .. "/.config/hypr/colors.lua")
  '';

  wayland.windowManager.hyprland.settings = {
    bind = [
      (hyprLib.mkBindExec "CTRL + SUPER + T" "~/.local/bin/wal")
      (hyprLib.mkBindExec "SUPER + SHIFT + T" "~/.local/bin/theme toggle")
    ];

    window_rule = [
      { match = { title = "^(Select Wallpaper)(.*)$"; }; float = true; center = true; }
    ];

    on = [
      (hyprLib.mkStartHook [ "sleep 0.5; ~/.local/bin/wal --boot" ])
    ];
  };
}
