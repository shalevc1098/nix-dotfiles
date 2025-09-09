{ pkgs, ... }:
{
  gtk = {
    enable = true;

    font.name = "Noto Sans";
    font.size = 10;

    # theme = {
    #   name    = "Adwaita-dark";
    #   package = pkgs.gnome-themes-extra;
    # };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
