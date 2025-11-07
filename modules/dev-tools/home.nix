{
  pkgs,
  ...
}:
{
  imports = [
    ./tools/c.nix
    ./tools/dotnet.nix
    ./tools/git.nix
    ./tools/node.nix
    ./tools/python.nix
    ./tools/sql.nix
    ./tools/vscode.nix
  ];
}
