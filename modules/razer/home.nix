{ ... }:
{
  xdg.configFile."autostart/polychromatic-autostart.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Polychromatic Autostart
    Exec=polychromatic-helper --autostart
    Hidden=true
  '';
}
