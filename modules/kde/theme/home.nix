{ inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    configFile = {
      "kdeglobals" = {
        "Icons" = {
          "Theme" = "breeze";
        };
      };
    };
  };
}
