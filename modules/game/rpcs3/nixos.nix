{ ... }:
{
  services.flatpak.packages = [
    "net.rpcs3.RPCS3"
  ];

  services.flatpak.overrides."net.rpcs3.RPCS3".Context.filesystems = [
    "host"
  ];
}
