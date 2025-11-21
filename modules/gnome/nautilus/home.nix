{
  wayland.windowManager.hyprland.settings = {
    # bind = [
    #   "$mainMod, E, exec, uwsm app -- nautilus --new-window"
    # ];

    windowrule = [
      # "match:class org.gnome.Nautilus, match:title ^(Save As)(.*)$, float on"
      # "match:class org.gnome.Nautilus, match:title ^(Save As)(.*)$, size (monitor_w*0.6) (monitor_h*0.65)"

      "match:class org.gnome.Nautilus, match:title ^(?!Loading\\.\\.\\.\\.).*, float on"
      "match:class org.gnome.Nautilus, match:title ^(?!Loading\\.\\.\\.\\.).*, size (monitor_w*0.6) (monitor_h*0.65)"
    ];
  };
}
