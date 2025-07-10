{ inputs, ... }:

let
  lib = inputs.nixpkgs.lib;

  module_paths = [
    # Core
    ../../modules/audio

    # Packages
    ../../modules/agsv1
    ../../modules/cliphist
    ../../modules/dev-tools
    ../../modules/hypr
    # ../../modules/fish
    ../../modules/fcitx5
    ../../modules/foot
    ../../modules/kde
    ../../modules/ssh
    ../../modules/starship
    ../../modules/swww
    ../../modules/wlogout
    ../../modules/wofi
    ../../modules/xiccd
    ../../modules/zsh

    # Theme
    ../../modules/theme

    # Apps
    ../../modules/game
  ];
  modules = lib.forEach module_paths (x: import x);

  nixosModules = lib.forEach modules (x: x.nixosModule);
  homeModules = lib.forEach modules (x: x.homeModule);
in

lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [
    # System
    ./core.nix

    # User
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };

      home-manager.users.shalev = {
        imports = homeModules;

        home.username = "shalev";
        home.homeDirectory = "/home/shalev";
        home.stateVersion = "25.05";
      };
    }
  ] ++ nixosModules;
}
