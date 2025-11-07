{
  homeModule = {
    imports = [
      ./quickemu/home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./qemu/nixos.nix
      ./quickemu/nixos.nix
      ./samba/nixos.nix
      ./virt-manager/nixos.nix
    ];
  };
}
