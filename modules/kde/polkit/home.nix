{ hyprLib, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.plasma-nm
    kdePackages.polkit-kde-agent-1
  ];

  wayland.windowManager.hyprland.settings.on = [
    (hyprLib.mkStartHook [ "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1" ])
  ];
}
