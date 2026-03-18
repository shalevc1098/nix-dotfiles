{
  homeModule = {
    imports = [
      ./minecraft/home.nix
      ./steam/home.nix
    ];
  };
  nixosModule =
    { inputs, ... }:
    {
      imports = [
        inputs.nix-gaming.nixosModules.pipewireLowLatency
        inputs.steam-presence.nixosModules.steam-presence

        ./aagl/nixos.nix
        ./steam/nixos.nix
      ];

      nix.settings = {
        substituters = [ "https://nix-gaming.cachix.org" ];
        trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
      };

      services.pipewire.lowLatency.enable = true;
    };
}
