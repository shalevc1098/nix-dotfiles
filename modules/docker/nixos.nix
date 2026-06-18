{
  pkgs,
  lib,
  username,
  ...
}:
{
  virtualisation.docker = {
    enable = true;
  };

  hardware.nvidia-container-toolkit.enable = true;

  users.users.${username}.extraGroups = [
    "docker"
  ];
}
