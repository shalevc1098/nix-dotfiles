{
  config,
  inputs,
  pkgs,
  ...
}:
let
  cursor = config.home.pointerCursor;
in
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
    hyprcursor.enable = true;
    x11.enable = true;
    gtk.enable = true;
  };

  programs.plasma = {
    enable = true;
    configFile = {
      "kcminputrc" = {
        "Mouse" = {
          "cursorSize" = cursor.size;
        };
      };
    };
  };
}
