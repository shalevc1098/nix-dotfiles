{
  config,
  username,
  ...
}:
{
  sops.secrets."restic_password" = { };

  services.restic.backups.home = {
    initialize = true;
    repository = "sftp:shalev@synology:/backups/nixos";
    passwordFile = config.sops.secrets.restic_password.path;
    paths = [ "/home/${username}" ];
    exclude = [
      "/home/${username}/.cache"
      "/home/${username}/.var/app/*/cache"
      "/home/${username}/.local/share/Steam/steamapps/common"
      "/home/${username}/vms"
      "**/node_modules"
    ];
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 6"
    ];
    timerConfig = {
      OnCalendar = "daily";
      Persist = true;
      RandomizedDelaySec = "1h";
    };
  };
}
