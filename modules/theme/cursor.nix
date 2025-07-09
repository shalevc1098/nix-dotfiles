{
  pkgs,
  ...
}:
{
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
    hyprcursor.enable = true;
    x11.enable = true;
    gtk.enable = true;
  };
}
