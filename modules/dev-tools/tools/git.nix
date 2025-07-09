{
  inputs,
  ...
}:
let
  git-config = import "${inputs.mysecrets}/git-config.nix";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = git-config.userName;
    userEmail = git-config.userEmail;
  };
}
