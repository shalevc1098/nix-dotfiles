{
  inputs,
  username,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.mysecrets}/keys.yaml";
    age.keyFile = "/var/lib/sops/age.key";

    secrets."ssh_id_ed25519" = {
      path = "/home/${username}/.ssh/id_ed25519";
      owner = username;
      mode = "0600";
    };
  };
}
