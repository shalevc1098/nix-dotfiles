{
  homeModule = {
    imports = [
      ./gthumb/home.nix
      ./keyring/home.nix
      ./nautilus/home.nix
      ./settings/home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./nautilus/nixos.nix
      # ./keyring/nixos.nix
    ];
  };
}
