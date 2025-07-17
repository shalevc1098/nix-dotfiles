{
  description = "Home Manager configuration of Shalev";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agsv1.url = "github:Aylur/ags?ref=v1";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # hyprlock = {
    #   url = "github:hyprwm/hyprlock";
    #   inputs = {
    #     hyprgraphics.follows = "hyprland/hyprgraphics";
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

    mysecrets = {
      url = "git+ssh://git@github.com/shalevc1098/nix-secrets?shallow=1";
      flake = false;
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  #   outputs =
  #     { nixpkgs, home-manager, ... }:
  #     let
  #       system = "x86_64-linux";
  #       pkgs = nixpkgs.legacyPackages.${system};
  #     in
  #     {
  #       homeConfigurations.shalev = home-manager.lib.homeManagerConfiguration {
  #         inherit pkgs;

  #         # Specify your home configuration modules here, for example,
  #         # the path to your home.nix.
  #         modules = [ ./home.nix ];

  #         # Optionally use extraSpecialArgs
  #         # to pass through arguments to home.nix
  #       };
  #     };

  outputs =
    { nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt-rfc-style;
        };
      flake = {
        nixosConfigurations.shalev = (import ./hosts/shalev) {
          inherit inputs;
        };
        nixosConfigurations.shalev-qemu = (import ./hosts/shalev-qemu) {
          inherit inputs;
        };
        nixosConfigurations.shalev-vmware = (import ./hosts/shalev-vmware) {
          inherit inputs;
        };
      };
    };
}
