{
  homeModule = {
    imports = [
      ./gthumb/home.nix
      ./nautilus/home.nix
      ./keyring/home.nix
      ./settings/home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./nautilus/nixos.nix
      ./keyring/nixos.nix
      ./settings/nixos.nix
    ];
  };
}
