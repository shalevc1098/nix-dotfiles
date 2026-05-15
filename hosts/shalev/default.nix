{ inputs, ... }:

let
  lib = inputs.nixpkgs.lib;

  module_paths = [
    # Core
    ../../modules/system

    # Packages
    # ../../modules/ags
    ../../modules/anime
    # ../../modules/apple
    ../../modules/anydesk
    ../../modules/audacity
    ../../modules/auto-clicker
    ../../modules/awww
    ../../modules/bottles
    ../../modules/cliphist
    ../../modules/dankmaterialshell
    ../../modules/desktops
    ../../modules/dev-tools
    ../../modules/docker
    # ../../modules/dunst
    # ../../modules/easyeffects
    ../../modules/fan-control
    # ../../modules/fcitx5
    # ../../modules/filebot
    ../../modules/filezilla
    ../../modules/firefox
    ../../modules/fish
    ../../modules/flatpak
    # ../../modules/foot
    # ../../modules/fuzzel
    ../../modules/gnome
    ../../modules/greetd
    ../../modules/gvfs
    ../../modules/hypr
    ../../modules/jellyfin-desktop
    ../../modules/kde
    # ../../modules/keyd
    ../../modules/kitty
    # ../../modules/libre-office
    ../../modules/localsend
    ../../modules/lyx
    ../../modules/matugen
    ../../modules/mission-center
    ../../modules/mpv
    ../../modules/network-discovery
    ../../modules/niri
    # ../../modules/noctalia
    ../../modules/obs-studio
    ../../modules/ollama
    ../../modules/opencode
    ../../modules/openrgb
    ../../modules/polkit
    ../../modules/qbittorrent
    # ../../modules/quickshell
    ../../modules/razer
    ../../modules/screenshot
    ../../modules/spotify
    ../../modules/sox
    ../../modules/ssh
    ../../modules/starship
    # ../../modules/sunshine
    # ../../modules/swayosd
    ../../modules/tailscale
    ../../modules/telegram
    ../../modules/vencord
    ../../modules/virtualization
    # ../../modules/waydroid
    ../../modules/wine
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
  ]
  ++ nixosModules;
}
