{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    filebot
  ];
}
