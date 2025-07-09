{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      # listener = [
      #   {
      #     timeout = 180;
      #     on-timeout = "loginctl lock-session";
      #   }
      #   {
      #     timeout = 240;
      #     on-timeout = "hyprctl dispatch dpms off";
      #     on-resume = "hyprctl dispatch dpms on";
      #   }
      # ];
    };
  };
}