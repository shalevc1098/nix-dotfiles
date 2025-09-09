{
  homeModule = {
    imports = [
      ./dolphin/home.nix
      ./kdeconnect/home.nix
      ./polkit/home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./settings/nixos.nix
    ];
  };
}
