{
  homeModule = { };
  nixosModule = {
    imports = [
      ./firewall/nixos.nix
    ];
  };
}
