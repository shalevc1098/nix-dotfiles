{
  homeModule = {
    imports = [
      ./bluetooth/home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./audio/nixos.nix
      ./bluetooth/nixos.nix
      ./graphics/nixos.nix
      ./nix-ld/nixos.nix
    ];
  };
}
