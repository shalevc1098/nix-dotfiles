{
  inputs,
  username,
  ...
}:
let
  git-config = import "${inputs.mysecrets}/git-config.nix";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = git-config.user.name;
        email = git-config.user.email;
        signingkey = "/home/${username}/.ssh/id_ed25519.pub";
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
    };
  };
}
