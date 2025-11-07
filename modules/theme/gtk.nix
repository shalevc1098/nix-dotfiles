{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gnome-themes-extra  # For color-reload-gtk-module
  ];

  gtk = {
    enable = true;

    font.name = "Noto Sans";
    font.size = 10;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-modules = "colorreload-gtk-module";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    
    gtk3.extraCss = ''
      @import url("colors.css");
    '';
    gtk4.extraCss = ''
      @import url("colors.css");
    '';
  };
}
