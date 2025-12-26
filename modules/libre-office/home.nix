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
}
