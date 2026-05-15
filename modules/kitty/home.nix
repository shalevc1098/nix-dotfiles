{
  config,
  hyprLib,
  ...
}:
{
  programs.kitty = {
    enable = true;
    settings = {
      # Include colors
      include = "~/.config/kitty/colors.conf";

      # Font
      font_family = "JetBrains Mono Nerd Font";
      font_size = 11.0;
      "symbol_map U+0590-U+05FF" = "CaskaydiaCove NF Light";

      # Cursor
      cursor_shape = "beam";
      cursor_trail = 1;

      # Padding (why weird value? consistent with foot)
      window_padding_width = 17;

      # No stupid close confirmation
      confirm_os_window_close = 0;

      # Use fish shell
      shell = "fish";

      # Remote control
      allow_remote_control = "yes";

      # Copy & Paste
      "map ctrl+c" = "copy_or_interrupt";
      "map ctrl+v" = "paste_from_clipboard";
      "map alt+v" = "launch --type=background --allow-remote-control --keep-focus ~/.local/bin/clip2path";

      # Search
      # "map ctrl+f" = "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
      # "map kitty_mod+f" = "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";

      # Scroll & Zoom
      "map page_up" = "scroll_page_up";
      "map page_down" = "scroll_page_down";

      "map ctrl+plus" = "change_font_size all +1";
      "map ctrl+equal" = "change_font_size all +1";
      "map ctrl+kp_add" = "change_font_size all +1";
      "map ctrl+minus" = "change_font_size all -1";
      "map ctrl+underscore" = "change_font_size all -1";
      "map ctrl+kp_subtract" = "change_font_size all -1";
      "map ctrl+0" = "change_font_size all 0";
      "map ctrl+kp_0" = "change_font_size all 0";
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      (hyprLib.mkBindExec "SUPER + T" "uwsm app -- kitty")
      (hyprLib.mkBindExec "SUPER + Return" "uwsm app -- kitty")
    ];
    window_rule = [
      { match = { class = "kitty"; }; opacity = "0.86 0.79"; }
    ];
  };

  xdg.desktopEntries.kitty-vim = {
    name = "Vim (Kitty)";
    exec = "kitty -e vim %F";
    icon = "vim";
    terminal = false;
    type = "Application";
    categories = [
      "Utility"
      "TextEditor"
    ];
    mimeType = [ "text/plain" ];
  };

  home.file.".local/bin/clip2path" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      if [ -n "$WAYLAND_DISPLAY" ]; then
          types=$(wl-paste --list-types)
          if grep -q '^image/' <<<"$types"; then
              ext=$(grep -m1 '^image/' <<<"$types" | cut -d/ -f2 | cut -d';' -f1)
              file="/tmp/clip_$(date +%s).''${ext}"
              wl-paste > "$file"
              printf '%q' "$file" | kitty @ send-text --stdin
          else
              wl-paste --no-newline | kitty @ send-text --stdin
          fi
      elif [ -n "$DISPLAY" ]; then
          types=$(xclip -selection clipboard -t TARGETS -o)
          if grep -q '^image/' <<<"$types"; then
              ext=$(grep -m1 '^image/' <<<"$types" | cut -d/ -f2 | cut -d';' -f1)
              file="/tmp/clip_$(date +%s).''${ext}"
              xclip -selection clipboard -t "image/''${ext}" -o > "$file"
              printf '%q' "$file" | kitty @ send-text --stdin
          else
              xclip -selection clipboard -o | kitty @ send-text --stdin
          fi
      fi
    '';
  };
}
