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
    settings = {
      user = {
        name = git-config.user.name;
        email = git-config.user.email;
      };
      safe.directory = [
        "/mnt/T7Shield/*"
        "/mnt/windows/*"
      ];
    };
  };
}
