{
  inputs,
  pkgs,
  ...
}:
let
  breeze-icons-patched = pkgs.callPackage ./breeze-icons-patched.nix { };
in
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  # Symlink patched icons to local directory (takes precedence over system icons)
  # home.file.".local/share/icons/breeze".source = "${breeze-icons-patched}/share/icons/breeze";
  # home.file.".local/share/icons/breeze-dark".source = "${breeze-icons-patched}/share/icons/breeze-dark";

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
