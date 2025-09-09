{
  config,
  inputs,
  pkgs,
  ...
}:
let
  matugen-git = inputs.matugen.packages.${pkgs.system}.default;
in
{
  home.packages = [
    # matugen-git
  ];

  home.file.".local/bin/wal" = {
    text = ''
      #!/bin/sh
      set -eu

      wallpaper=$(${pkgs.coreutils}/bin/readlink -f "$1")
      ${matugen-git}/bin/matugen image "''${wallpaper}" 1>/dev/null -t scheme-vibrant
    '';

    executable = true;
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
    output_path = "~/.config/dankmaterialshell/colors.json"

    [templates.discord_midnight]
    input_path = "${./templates/discord/midnight.css}"
    output_path = "~/.config/vesktop/themes/midnight-discord.css"

    [templates.gtk3]
    input_path = "${./templates/gtk/colors.css}"
    output_path = "~/.config/gtk-3.0/gtk.css"

    [templates.gtk4]
    input_path = "${./templates/gtk/colors.css}"
    output_path = "~/.config/gtk-4.0/gtk.css"

    [templates.fish]
    input_path = "${./templates/fish/colors.fish}"
    output_path = "~/.config/fish/colors.fish"

    [templates.foot]
    input_path = "${./templates/foot/colors.ini}"
    output_path = "~/.config/foot/colors.ini"

    [templates.hyprland]
    input_path = '${./templates/hyprland/colors.conf}'
    output_path = '~/.config/hypr/colors.conf'
    post_hook = 'hyprctl reload'

    [templates.hyprlock]
    input_path = "${./templates/hyprland/hyprlock.conf}"
    output_path = '~/.config/hypr/hyprlock.conf'

    [templates.noctalia]
    input_path = "${./templates/noctalia/colors.json}"
    output_path = "~/.config/noctalia/colors.json"

    [templates.pywalfox]
    input_path = "${./templates/pywalfox/colors.json}"
    output_path = "~/.cache/wal/colors.json"

    [templates.quickshell]
    input_path = "${./templates/quickshell/colors.json}"
    output_path = "~/.local/quickshell/colors.json"

    [templates.wallpaper]
    input_path = "${./templates/wallpaper.txt}"
    output_path = "~/.local/state/wallpaper.txt"

    [templates.waybar]
    input_path = "${./templates/waybar/colors.css}"
    output_path = "~/.config/waybar/colors.css"
  '';

  wayland.windowManager.hyprland.settings.exec-once = [
    "exec-once = sleep 0.5; wal \"$(cat ~/.local/state/wallpaper.txt || ~/Pictures/Wallpapers/wallpaper.png)\""
  ];
}
