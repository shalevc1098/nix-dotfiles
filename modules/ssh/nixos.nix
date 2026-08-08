{
  lib,
  pkgs,
  ...
}:
{
  programs.ssh = {
    startAgent = false;
    askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

    # restic runs as root and would otherwise stop on the host key prompt
    knownHosts.truenas = {
      hostNames = [
        "truenas"
        "100.108.96.85"
        "192.168.1.192"
      ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA7+5bUGuiyJ81XuSVa3wcEyXcHNWeVckOhDF8eVT0KX";
    };
  };
}
