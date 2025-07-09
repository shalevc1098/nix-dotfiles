{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    wlogout
  ];

  programs.wlogout = {
    enable = true;
    layout = [
      {
        action = "loginctl lock-session";
        keybind = "l";
        label = "lock";
        text = "lock";
      }
      {
        action = "systemctl hibernate || loginctl hibernate";
        keybind = "h";
        label = "hibernate";
        text = "save";
      }
      {
        action = "uwsm stop";
        keybind = "e";
        label = "logout";
        text = "logout";
      }
      {
        action = "systemctl poweroff || loginctl poweroff";
        keybind = "s";
        label = "shutdown";
        text = "power_settings_new";
      }
      {
        action = "systemctl suspend || loginctl suspend";
        keybind = "u";
        label = "suspend";
        text = "bedtime";
      }
      {
        action = "systemctl reboot || loginctl reboot";
        keybind = "r";
        label = "reboot";
        text = "restart_alt";
      }
    ];
    style = ''
      * {
        all: unset;
        background-image: none;
        transition: 400ms cubic-bezier(0.05, 0.7, 0.1, 1);
      }

      window {
        background: rgba(0, 0, 0, 0.5);
      }

      button {
        font-family: 'Material Symbols Outlined';
        font-size: 10rem;
        background-color: rgba(11, 11, 11, 0.4);
        color: #FFFFFF;
        margin: 2rem;
        border-radius: 2rem;
        padding: 3rem;
      }

      button:focus,
      button:active,
      button:hover {
        background-color: rgba(51, 51, 51, 0.5);
        border-radius: 4rem;
      }
    '';
  };

  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, logout_dialog"
    ];
  };
}
