{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    gdb
    valgrind
    clang-tools
  ];
}
