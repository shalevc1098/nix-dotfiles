{
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

  wayland.windowManager.hyprland.settings.exec-once = [
    "fcitx5"
  ];

  wayland.windowManager.hyprland.settings.env = [
    "QT_IM_MODULE, fcitx"
    "XMODIFIERS, @im=fcitx"
    "SDL_IM_MODULE, fcitx"
    "GLFW_IM_MODULE, ibus"
    "INPUT_METHOD, fcitx"
  ];
}
