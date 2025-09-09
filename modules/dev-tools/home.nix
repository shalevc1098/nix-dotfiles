{
  pkgs,
  ...
}:
{
  imports = [
    ./tools/git.nix
    ./tools/node.nix
    ./tools/vscode.nix
  ];
}
