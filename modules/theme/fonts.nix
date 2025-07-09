{
  lib,
  pkgs,
  ...
}:
{
  # Fonts
  fonts.fontconfig.enable = lib.mkDefault true;
  home.packages =
    with pkgs;
    [
      adwaita-icon-theme
      catppuccin-cursors
      culmus
      dejavu_fonts
      font-awesome
      material-symbols
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-extra
      papirus-icon-theme
      source-code-pro
      # monaco (available via NUR)
      # ttf-ms-win11-auto (not in main nixpkgs)
    ]
    ++ (with pkgs.nerd-fonts; [
      caskaydia-cove
      fantasque-sans-mono
      fira
      fira-code
      jetbrains-mono
      mononoki
      space-mono
      ubuntu
      ubuntu-mono
    ]);
}
