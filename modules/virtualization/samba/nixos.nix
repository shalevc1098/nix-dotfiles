{
  username,
  ...
}:
{
  services.samba = {
    enable = true;
    settings = {
      global = {
        "allow insecure wide links" = "yes";
        "unix extensions" = "no";
        "follow symlinks" = "yes";
        "wide links" = "yes";
        "map to guest" = "bad user";
      };

      home = {
        path = "/home/${username}";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "guest only" = "yes";
        "force user" = username;
        "follow symlinks" = "yes";
        "wide links" = "yes";
      };
    };
  };
}
