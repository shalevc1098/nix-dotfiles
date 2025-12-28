{
  pkgs,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        # command = "niri-session";
        user = "shalev";
      };
      default_session = initial_session;
    };
  };
}
