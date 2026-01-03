{
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      allow_images = true;
      image_size = 16;
      no_actions = true;
    };
  };

  # Disabled - Super key binding moved to keybinds.nix with quickshell/fuzzel
  # wayland.windowManager.hyprland.settings = {
  #   bind = [
  #     "Super, Super_L, exec, pgrep wofi && pkill wofi || wofi"
  #   ];
  # };
}
