{ pkgs, ... }:
{
  home.packages = [ pkgs.gnome-keyring ];
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gnome-keyring/ssh";
  };
}
