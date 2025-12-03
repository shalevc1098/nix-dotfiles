{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nodejs
  ];

  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npm-global/.keep".text = "";
}
