{
  username,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        # uwsm supervision tears the session down mid-startup
        command = "Hyprland";
        user = username;
      };
      default_session = initial_session;
    };
  };
}
