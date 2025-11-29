{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pkgs.prismlauncher
  ];
}
