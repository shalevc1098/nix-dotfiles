{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    dotnet-sdk
    dotnet-sdk_6
    dotnet-sdk_7
    dotnet-sdk_8
  ];
}
