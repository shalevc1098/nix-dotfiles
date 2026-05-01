{
  config,
  pkgs,
  username,
  ...
}:
{
  programs.ydotool.enable = true;

  users.users.${username}.extraGroups = [
    config.programs.ydotool.group
  ];
}
