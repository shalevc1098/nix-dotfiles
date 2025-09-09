{
  programs.fuzzel = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "Super, Super_L, exec, LANG=en_IL.UTF-8 fuzzel"
  ];
}
