{
  pkgs,
  ...
}:
{
  networking.firewall = {
    allowedTCPPorts = [ 8096 8111 ];
  };
}
