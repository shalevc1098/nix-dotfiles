{
  homeModule = { };
  nixosModule = {
    imports = [
      ./audio/nixos.nix
      ./bluetooth/nixos.nix
      ./graphics/nixos.nix
    ];
  };
}
