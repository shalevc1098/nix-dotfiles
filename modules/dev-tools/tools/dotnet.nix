{
  pkgs,
  ...
}:
let
  dotnet-combined = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnet-sdk_8
    pkgs.dotnet-sdk_10
  ];
in
{
  home.packages = [ dotnet-combined ];

  home.sessionVariables = {
    DOTNET_ROOT = "${dotnet-combined}/share/dotnet";
  };

  home.sessionPath = [
    "$HOME/.dotnet/tools"
  ];
}
