{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.he_IL
  ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class ^(libreoffice.*)$, opacity 0.86 0.79"
  ];
}
