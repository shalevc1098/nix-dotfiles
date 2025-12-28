{
  windowrule = [
    # Blur all windows
    "match:class .*, opacity 0.86 0.79"

    # Disable blur for XWayland windows (or context menus with shadow would look weird)
    "match:xwayland 1, no_blur on"

    # Floating windows
    "match:class ^(blueberry\\.py)$, float on"
    "match:class ^(steam)$, float on"
    "match:class ^(guifetch)$, float on"
    "match:class ^(pavucontrol)$, float on"
    "match:class ^(pavucontrol)$, size (monitor_w*0.45)"
    "match:class ^(pavucontrol)$, center on"
    "match:class ^(org.pulseaudio.pavucontrol)$, float on"
    "match:class ^(org.pulseaudio.pavucontrol)$, size (monitor_w*0.45)"
    "match:class ^(org.pulseaudio.pavucontrol)$, center on"
    "match:class ^(nm-connection-editor)$, float on"
    "match:class ^(nm-connection-editor)$, size (monitor_w*0.45)"
    "match:class ^(nm-connection-editor)$, center on"
    "match:class ^(heroic)$, float on"

    # Tiling
    "match:class ^dev\\.warp\\.Warp$, tile on"

    # Picture-in-Picture
    "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$, float on"
    "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$, keep_aspect_ratio on"
    "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$, move 73% 72%"
    "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$, size (monitor_w*0.25)"
    "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$, pin on"

    # Dialog windows – float+center these windows.
    "match:title ^(Open File)(.*)$, center on"
    "match:title ^(Select a File)(.*)$, center on"
    "match:title ^(Choose wallpaper)(.*)$, center on"
    "match:title ^(Open Folder)(.*)$, center on"
    "match:title ^(Save As)(.*)$, center on"
    "match:title ^(Library)(.*)$, center on"
    "match:title ^(File Upload)(.*)$, center on"
    "match:title ^(Open File)(.*)$, float on"
    "match:title ^(Select a File)(.*)$, float on"
    "match:title ^(Choose wallpaper)(.*)$, float on"
    "match:title ^(Open Folder)(.*)$, float on"
    "match:title ^(Save As)(.*)$, float on"
    "match:title ^(Library)(.*)$, float on"
    "match:title ^(File Upload)(.*)$, float on"

    # Tearing
    "match:title .*\\.exe, immediate on"
    "match:class ^(steam_app), immediate on"

    # No shadow for tiled windows (matches windows that are not floating).
    # "match:float 0, no_shadow on"
  ];

  workspace = [
    "special:special, gapsout:30"
  ];

  layerrule = [
    "match:namespace .*, xray on"
    # "match:namespace .*, no_anim on"
    "match:namespace walker, no_anim on"
    "match:namespace selection, no_anim on"
    "match:namespace overview, no_anim on"
    "match:namespace anyrun, no_anim on"
    "match:namespace indicator.*, no_anim on"
    "match:namespace osk, no_anim on"
    "match:namespace hyprpicker, no_anim on"
    "match:namespace noanim, no_anim on"
    "match:namespace gtk-layer-shell, blur on"
    "match:namespace gtk-layer-shell, ignore_alpha 0.0"
    "match:namespace launcher, blur on"
    "match:namespace launcher, ignore_alpha 0.5"
    "match:namespace notifications, blur on"
    "match:namespace notifications, ignore_alpha 0.69"
    "match:namespace logout_dialog, blur on"
  ];
}