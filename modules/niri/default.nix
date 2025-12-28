{
  homeModule = {
    imports = [
      ./home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./nixos.nix
    ];
  };
}
