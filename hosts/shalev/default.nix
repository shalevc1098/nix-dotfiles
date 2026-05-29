{ inputs, ... }:

let
  lib = inputs.nixpkgs.lib;

  username = "shalev";

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
    ../../modules/bitwarden-cli
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
    # ../../modules/noctalia
    ../../modules/obs-studio
    # ../../modules/ollama
    ../../modules/opencode
    ../../modules/openrgb
    ../../modules/polkit
    ../../modules/qbittorrent
    # ../../modules/quickshell
    ../../modules/razer
    ../../modules/restic
    ../../modules/screenshot
    ../../modules/spotify
    ../../modules/sops
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

  hyprLib = import ../../modules/hypr/hyprland/lib.nix { inherit lib; };

  hostMonitors = [
    {
      output = "desc:ASUSTek COMPUTER INC PG32UCDM T7LMQS094714";
      mode = "3840x2160@240.02Hz";
      position = "0x0";
      scale = 1.5;
    }
    {
      output = "desc:Dell Inc. AW3225QF 68F3YZ3";
      mode = "3840x2160@239.99Hz";
      position = "auto";
      scale = 1.5;
    }
  ];

in

lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit inputs username;
  };
  modules = [
    # System
    ./core.nix

    # User
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs hyprLib hostMonitors username; };
      home-manager.backupFileExtension = "backup";

      home-manager.users.${username} = {
        imports = homeModules;

        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.05";
      };
    }
  ]
  ++ nixosModules;
}
