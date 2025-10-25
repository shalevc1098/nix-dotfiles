{ inputs, ... }:

let
  lib = inputs.nixpkgs.lib;

  module_paths = [
    # Core
    ../../modules/audio

    # Packages
    # ../../modules/ags
    ../../modules/anime
    ../../modules/bluetooth
    ../../modules/bottles
    ../../modules/cliphist
    ../../modules/dankmaterialshell
    ../../modules/desktops
    ../../modules/dev-tools
    ../../modules/docker
    # ../../modules/dunst
    ../../modules/hypr
    ../../modules/fan-control
    # ../../modules/fcitx5
    # ../../modules/filebot
    ../../modules/fish
    ../../modules/firefox
    # ../../modules/foot
    # ../../modules/fuzzel
    ../../modules/gnome
    ../../modules/greetd
    ../../modules/kde
    ../../modules/kitty
    ../../modules/matugen
    ../../modules/mpv
    # ../../modules/noctalia
    ../../modules/lyx
    ../../modules/obs-studio
    ../../modules/openrgb
    ../../modules/polkit
    ../../modules/qbittorrent
    # ../../modules/quickshell
    ../../modules/screenshot
    ../../modules/spotify
    ../../modules/ssh
    ../../modules/starship
    # ../../modules/swayosd
    ../../modules/swww
    ../../modules/vencord
    ../../modules/virtualization
    # ../../modules/waybar
    ../../modules/wlogout
    ../../modules/wlsunset
    ../../modules/wofi
    ../../modules/xdg
    ../../modules/xiccd
    ../../modules/zoom
    # ../../modules/zsh

    # Theme
    ../../modules/theme

    # Apps
    ../../modules/game
  ];
  modules = lib.forEach module_paths (x: import x);

  nixosModules = lib.forEach modules (x: x.nixosModule);
  homeModules = lib.forEach modules (x: x.homeModule);
in

lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit inputs;
    username = "shalev";
  };
  modules = [
    # System
    ./core.nix

    # User
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.backupFileExtension = "backup";

      home-manager.users.shalev = {
        imports = homeModules;

        home.username = "shalev";
        home.homeDirectory = "/home/shalev";
        home.stateVersion = "25.05";
      };
    }
  ] ++ nixosModules;
}
