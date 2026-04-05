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

  # Auto-update Flatpak daily
  systemd.services.flatpak-update = {
    description = "Update Flatpak packages";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.flatpak}/bin/flatpak update -y --noninteractive";
    };
  };

  systemd.timers.flatpak-update = {
    description = "Auto-update Flatpak packages daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
