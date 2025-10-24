{
  lib,
  pkgs,
  ...
}:
{
  programs.ssh = {
    startAgent = false;
    askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  };
}
