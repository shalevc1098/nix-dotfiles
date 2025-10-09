{
  pkgs,
  ...
}:
{
  imports = [
    ./tools/dotnet.nix
    ./tools/git.nix
    ./tools/node.nix
    ./tools/sql.nix
    ./tools/vscode.nix
  ];
}
