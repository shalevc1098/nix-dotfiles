{
  pkgs,
  config,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
  ];

  virtualisation.libvirtd.enable = true;

  users.users.${username}.extraGroups = [
    "libvirtd"
  ];
}
