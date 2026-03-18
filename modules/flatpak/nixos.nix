{ config, pkgs, ... }:
let
  nvidiaVersion = builtins.replaceStrings [ "." ] [ "-" ]
    config.hardware.nvidia.package.version;
in
{
  services.flatpak.enable = true;

  # Auto-install matching Flatpak NVIDIA GL runtime on rebuild
  system.activationScripts.flatpak-nvidia-gl.text = ''
    ${pkgs.flatpak}/bin/flatpak install --noninteractive --system flathub org.freedesktop.Platform.GL.nvidia-${nvidiaVersion} 2>/dev/null || true
  '';
}
