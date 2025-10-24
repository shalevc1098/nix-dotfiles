{
  wayland.windowManager.hyprland.settings = {
    # bind = [
    #   "$mainMod, E, exec, uwsm app -- nautilus --new-window"
    # ];

    windowrulev2 = [
      # "float, class:org.gnome.Nautilus, title:^(Save As)(.*)$"
      # "size 60% 65%, class:org.gnome.Nautilus, title:^(Save As)(.*)$"

      "float, class:org.gnome.Nautilus, title:^(?!Loading\\.\\.\\.$).*"
      "size 60% 65%, class:org.gnome.Nautilus, title:^(?!Loading\\.\\.\\.$).*"
    ];
  };
}
