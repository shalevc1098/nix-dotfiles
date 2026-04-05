{
  username,
  ...
}:
{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "allow insecure wide links" = "yes";
        "unix extensions" = "no";
        "follow symlinks" = "yes";
        "wide links" = "yes";
        "vfs objects" = "recycle";
        "recycle:repository" = ".recycle";
        "recycle:keeptree" = "yes";
        "recycle:versions" = "yes";
      };

      home = {
        path = "/home/${username}";
        browseable = "yes";
        "read only" = "no";
        "valid users" = username;
        "follow symlinks" = "yes";
        "wide links" = "yes";
      };

      root = {
        path = "/";
        browseable = "yes";
        "read only" = "no";
        "valid users" = username;
        "follow symlinks" = "yes";
        "wide links" = "yes";
      };
    };
  };
}
