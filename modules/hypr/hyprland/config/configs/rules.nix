{
  windowrulev2 = [
    # Disable blur for XWayland windows (or context menus with shadow would look weird)
    "noblur, xwayland:1"

    # Floating windows
    "float, class:^(blueberry\\.py)$"
    "float, class:^(steam)$"
    "float, class:^(guifetch)$"
    "float, class:^(pavucontrol)$"
    "size 45%, class:^(pavucontrol)$"
    "center, class:^(pavucontrol)$"
    "float, class:^(org.pulseaudio.pavucontrol)$"
    "size 45%, class:^(org.pulseaudio.pavucontrol)$"
    "center, class:^(org.pulseaudio.pavucontrol)$"
    "float, class:^(nm-connection-editor)$"
    "size 45%, class:^(nm-connection-editor)$"
    "center, class:^(nm-connection-editor)$"
    "float, class:^(org.qbittorrent.qBittorrent)$"
    "float, class:^(heroic)$"
    "float, class:^(zoom)$"

    # Tiling
    "tile, class:^dev\\.warp\\.Warp$"

    # Picture-in-Picture
    "float, title:^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
    "keepaspectratio, title:^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
    "move 73% 72%, title:^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
    "size 25%, title:^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
    "float, title:^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
    "pin, title:^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"

    # Dialog windows – float+center these windows.
    "center, title:^(Open File)(.*)$"
    "center, title:^(Select a File)(.*)$"
    "center, title:^(Choose wallpaper)(.*)$"
    "center, title:^(Open Folder)(.*)$"
    "center, title:^(Save As)(.*)$"
    "center, title:^(Library)(.*)$"
    "center, title:^(File Upload)(.*)$"
    "float, title:^(Open File)(.*)$"
    "float, title:^(Select a File)(.*)$"
    "float, title:^(Choose wallpaper)(.*)$"
    "float, title:^(Open Folder)(.*)$"
    "float, title:^(Save As)(.*)$"
    "float, title:^(Library)(.*)$"
    "float, title:^(File Upload)(.*)$"

    # Tearing
    "immediate, title:.*\\.exe"
    "immediate, class:^(steam_app)"

    # No shadow for tiled windows (matches windows that are not floating).
    "noshadow, floating:0"
  ];

  workspace = [
    "special:special, gapsout:30"
  ];

  layerrule = [
    "xray 1, .*"
    # "noanim, .*"
    "noanim, walker"
    "noanim, selection"
    "noanim, overview"
    "noanim, anyrun"
    "noanim, indicator.*"
    "noanim, osk"
    "noanim, hyprpicker"
    "noanim, noanim"
    "blur, gtk-layer-shell"
    "ignorezero, gtk-layer-shell"
    "blur, launcher"
    "ignorealpha 0.5, launcher"
    "blur, notifications"
    "ignorealpha 0.69, notifications"
    "blur, logout_dialog"
  ];
}