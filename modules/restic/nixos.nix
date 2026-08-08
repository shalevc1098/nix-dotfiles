{
  config,
  username,
  ...
}:
{
  sops.secrets."restic_password" = { };

  services.restic.backups.home = {
    initialize = true;
    repository = "sftp:shalev@truenas:/mnt/hdd/backups/nixos";
    passwordFile = config.sops.secrets.restic_password.path;
    paths = [ "/home/${username}" ];
    exclude = [
      "/home/${username}/.cache"
      "/home/${username}/.var"
      "/home/${username}/.local/share/Steam/steamapps/common"
      "/home/${username}/vms"
      "/home/${username}/user"
      "**/node_modules"
    ];
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 6"
    ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };
}
