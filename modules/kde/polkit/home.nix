{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.plasma-nm
    kdePackages.polkit-kde-agent-1
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1"
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "sh" "-c" "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1" ]; }
  ];
}
