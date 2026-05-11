{
  homeModule = {
    imports = [
      ./ark/home.nix
      ./dolphin/home.nix
      ./gwenview/home.nix
      ./kate/home.nix
      # ./kdeconnect/home.nix
      ./kwallet/home.nix
      # ./polkit/home.nix
      ./theme/home.nix
      ./theme/kde-material-you-colors.nix
    ];
  };
  nixosModule = {
    imports = [
      ./ark/nixos.nix
      ./dolphin/nixos.nix
      ./kdeconnect/nixos.nix
      ./kwallet/nixos.nix
      ./settings/nixos.nix
    ];
  };
}
