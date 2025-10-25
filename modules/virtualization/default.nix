{
  homeModule = {
    imports = [

    ];
  };
  nixosModule = {
    imports = [
      ./qemu/nixos.nix
      ./quickemu/nixos.nix
      ./virt-manager/nixos.nix
    ];
  };
}
