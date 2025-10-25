{
  homeModule = {
    imports = [

    ];
  };
  nixosModule = {
    imports = [
      ./qemu/nixos.nix
      ./quickemu/nixos.nix
    ];
  };
}
