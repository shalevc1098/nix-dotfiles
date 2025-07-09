{
  pkgs,
  ...
}:
{
  imports = [
    ./tools/git.nix
    ./tools/vscode.nix
  ];
}
