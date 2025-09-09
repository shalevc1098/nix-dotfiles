{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (if pkgs ? nodejs_22 then nodejs_22 else nodejs_20)
    corepack
  ];

  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npm-global/.keep".text = "";
}
