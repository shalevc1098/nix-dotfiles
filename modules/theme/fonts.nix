{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  # Fonts
  fonts.fontconfig.enable = lib.mkDefault true;
  
  # Configure fontconfig to prefer Apple Color Emoji
  xdg.configFile."fontconfig/conf.d/10-apple-emoji.conf".text = builtins.readFile ./fontconfig/10-apple-emoji.conf;
  home.packages =
    with pkgs;
    [
      # Apple Color Emoji (at the top for priority)
      inputs.apple-emoji-linux.packages.${pkgs.system}.default
      
      catppuccin-cursors
      culmus
      dejavu_fonts
      font-awesome
      material-symbols
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      # noto-fonts-emoji  # Replaced with Apple Color Emoji
      noto-fonts
      source-code-pro
      corefonts
      # monaco (available via NUR)
      # ttf-ms-win11-auto (not in main nixpkgs)
      
      # Apple fonts (all languages)
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro
      inputs.apple-fonts.packages.${pkgs.system}.sf-compact
      inputs.apple-fonts.packages.${pkgs.system}.sf-mono
      inputs.apple-fonts.packages.${pkgs.system}.sf-arabic
      inputs.apple-fonts.packages.${pkgs.system}.sf-armenian
      inputs.apple-fonts.packages.${pkgs.system}.sf-georgian
      inputs.apple-fonts.packages.${pkgs.system}.sf-hebrew
      inputs.apple-fonts.packages.${pkgs.system}.ny
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
