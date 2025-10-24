{
  pkgs,
  ...
}:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        include = "~/.config/fuzzel/fuzzel_theme.ini";
        terminal = "''${pkgs.kitty}/bin/kitty -1";
        prompt = "\">>  \"";
        layer = "overlay";
      };
      border = {
        radius = 17;
        width = 1;
      };
      dmenu = {
        exit-immediately-if-empty = "yes";
      };
    };
  };

  # wayland.windowManager.hyprland.settings.bind = [
  #   "Super, Super_L, exec, LANG=en_IL.UTF-8 fuzzel"
  # ];
}
