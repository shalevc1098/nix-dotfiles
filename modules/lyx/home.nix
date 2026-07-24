{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ((kdePackages.callPackage "${pkgs.path}/pkgs/by-name/ly/lyx/package.nix" {
      libsForQt5 = kdePackages;
    }).overrideAttrs (oldAttrs: {
      configureFlags = [ "--enable-qt6" ] ++ (builtins.filter (flag: flag != "--enable-qt5") oldAttrs.configureFlags);

      # Skip tests - they have linking issues with Qt6
      doCheck = false;
    }))

    (texlive.combine {
      inherit (texlive)
        scheme-full
        collection-xetex
        collection-langarabic
        ;
    })

    culmus
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    { match = { class = "lyx"; }; opacity = "0.86 0.79"; }
  ];
}
