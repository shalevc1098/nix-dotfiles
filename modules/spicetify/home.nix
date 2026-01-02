{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
    };

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class spotify, opacity 0.86 0.79"
  ];
}
