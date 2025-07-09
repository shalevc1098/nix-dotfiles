{
  windowrulev2 = [
    # Disable blur for XWayland windows (or context menus with shadow would look weird)
    "noblur, xwayland:1"

    # Tiling
    "tile, class:^dev\\.warp\\.Warp$"

    # Picture-in-Picture
    "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
    "keepaspectratio, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
    "move 73% 72%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
    "size 25%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
    "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
    "pin, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"

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
    "immediate, title:.*\.exe"
    "immediate, class:^(steam_app)"

    # No shadow for tiled windows (matches windows that are not floating).
    "noshadow, floating:0"
  ];

  workspace = [
    "special:special, gapsout:30"
  ];

  layerrule = [
    "xray 1, .*"
  ];
}