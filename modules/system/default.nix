{
  homeModule = {
    imports = [
      ./flatpak/home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./audio/nixos.nix
      ./bluetooth/nixos.nix
      ./flatpak/nixos.nix
      ./graphics/nixos.nix
      ./nix-ld/nixos.nix
    ];
  };
}
