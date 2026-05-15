{
  hyprLib,
  pkgs,
  ...
}:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        libsForQt5.fcitx5-qt
      ];
    };
  };

  home.packages = with pkgs; [
    fcitx5-gtk
  ];

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "fcitx5" ]; }
    ];
    environment = {
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
      INPUT_METHOD = "fcitx";
    };
  };

  wayland.windowManager.hyprland.settings = {
    on = [
      (hyprLib.mkStartHook [ "fcitx5" ])
    ];
    env = [
      (hyprLib.mkEnv "QT_IM_MODULE" "fcitx")
      (hyprLib.mkEnv "XMODIFIERS" "@im=fcitx")
      (hyprLib.mkEnv "SDL_IM_MODULE" "fcitx")
      (hyprLib.mkEnv "GLFW_IM_MODULE" "ibus")
      (hyprLib.mkEnv "INPUT_METHOD" "fcitx")
    ];
  };
}
