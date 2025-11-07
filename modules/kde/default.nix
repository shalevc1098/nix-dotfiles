{
  homeModule = {
    imports = [
      ./dolphin/home.nix
      ./gwenview/home.nix
      ./kate/home.nix
      # ./kdeconnect/home.nix
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
      ./settings/nixos.nix
    ];
  };
}
