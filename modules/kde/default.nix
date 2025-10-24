{
  homeModule = {
    imports = [
      ./dolphin/home.nix
      ./kate/home.nix
      # ./kdeconnect/home.nix
      # ./polkit/home.nix
      ./theme/kde-material-you-colors.nix
    ];
  };
  nixosModule = {
    imports = [
      ./dolphin/nixos.nix
      ./kdeconnect/nixos.nix
      ./settings/nixos.nix
    ];
  };
}
