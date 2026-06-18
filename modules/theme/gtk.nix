{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gnome-themes-extra  # For color-reload-gtk-module
    adw-gtk3
  ];

  gtk = {
    enable = true;

    font.name = "Noto Sans";
    font.size = 10;

    gtk4.theme = null;

    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };

    gtk3.extraConfig = {
# gtk-application-prefer-dark-theme = true;
      gtk-modules = "colorreload-gtk-module";
    };
    gtk4.extraConfig = {
# gtk-application-prefer-dark-theme = true;
    };
    
    gtk3.extraCss = ''
      @import url("colors.css");
    '';
    gtk4.extraCss = ''
      @import url("colors.css");
    '';
  };
}
