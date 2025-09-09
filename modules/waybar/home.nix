{ lib, pkgs, ... }:
{

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        reload_style_on_change = true;
        modules-left = [
          "custom/notification"
          "clock"
          "custom/pacman"
          "tray"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "group/expand"
          "custom/weather"
          "bluetooth"
          "network"
          "battery"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          "format-icons" = {
            active = "";
            default = "";
            empty = "";
          };
          "persistent-workspaces" = {
            "*" = [
              1
              2
              3
              4
              5
            ];
          };
        };

        "custom/notification" = {
          tooltip = false;
          format = "";
          "on-click" = "swaync-client -t -sw";
          escape = true;
        };

        clock = {
          format = "{:%I:%M:%S %p} ";
          interval = 1;
          "tooltip-format" = "<tt>{calendar}</tt>";
          calendar = {
            format = {
              today = "<span color='#fAfBfC'><b>{}</b></span>";
            };
          };
          actions = {
            "on-click-right" = "shift_down";
            "on-click" = "shift_up";
          };
        };

        network = {
          "format-wifi" = "";
          "format-ethernet" = "";
          "format-disconnected" = "";
          "tooltip-format-disconnected" = "Error";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
          "tooltip-format-ethernet" = "{ifname} 🖧 ";
          "on-click" = "kitty --title KittyNmtui sh -c 'sleep 0.1; nmtui'";
        };

        "custom/weather" = {
          format = "{}";
          "format-alt" = "{alt}: {}";
          "format-alt-click" = "click";
          interval = 3600;
          "return-type" = "json";
          exec = "$HOME/.config/waybar/scripts/Weather.py";
          tooltip = true;
        };

        bluetooth = {
          "format-on" = "󰂯";
          "format-off" = "BT-off";
          "format-disabled" = "󰂲";
          "format-connected-battery" = "{device_battery_percentage}% 󰂯";
          "format-alt" = "{device_alias} 󰂯";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" =
            "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\n{device_address}";
          "tooltip-format-enumerate-connected-battery" =
            "{device_alias}\n{device_address}\n{device_battery_percentage}%";
          "on-click-right" = "blueman-manager";
        };

        battery = {
          interval = 30;
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{capacity}% {icon}";
          "format-charging" = "{capacity}% 󰂄";
          "format-plugged" = "{capacity}% 󰂄 ";
          "format-alt" = "{time} {icon}";
          "format-icons" = [
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };

        "custom/pacman" = {
          format = "󰅢 {}";
          interval = 30;
          exec = "checkupdates | wc -l";
          "exec-if" = "exit 0";
          "on-click" =
            "kitty --title PacUpdate sh -c 'sleep 0.1; paru -Syu; echo Done - Press enter to exit; read'; pkill -SIGRTMIN+8 waybar";
          signal = 8;
          tooltip = false;
        };

        "custom/expand" = {
          format = "";
          tooltip = false;
        };

        "custom/endpoint" = {
          format = "|";
          tooltip = false;
        };

        "group/expand" = {
          orientation = "horizontal";
          drawer = {
            "transition-duration" = 600;
            "transition-to-left" = true;
            "click-to-reveal" = true;
          };
          modules = [
            "custom/expand"
            "custom/colorpicker"
            "cpu"
            "memory"
            "temperature"
            "custom/endpoint"
          ];
        };

        "custom/colorpicker" = {
          format = "{}";
          "return-type" = "json";
          interval = "once";
          exec = "~/.config/waybar/scripts/Colorpicker.sh -j";
          "on-click" = "~/.config/waybar/scripts/Colorpicker.sh";
          signal = 1;
        };

        cpu = {
          format = "󰻠";
          tooltip = true;
        };

        memory = {
          format = "";
        };

        temperature = {
          "critical-threshold" = 80;
          format = "";
        };

        tray = {
          "icon-size" = 14;
          spacing = 10;
        };
      };
    };
    style = ''
      @import "./colors.css";

      * {
          font-size: 12px;
          font-family: JetBrainsMono Nerd Font;
          font-weight: bold;
      }
      window#waybar{
          all:unset;
      }
      .modules-left {
          padding: 7px;
          margin: 10px 0px 5px 10px;
          border-radius: 10px;
          background: alpha(@background,.6);
          box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }
      .modules-center {
          padding: 7px;
          margin: 10px 0px 5px 0px;
          border-radius: 10px;
          background: alpha(@background,.6);
          box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }
      .modules-right {
          padding:7px;
          margin: 10px 10px 5px 0px;
          border-radius: 10px;
          background: alpha(@background,.6);
          box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }
      tooltip {
          background: @background;
          border: 2px solid @primary;
          border-radius: 12px;
      }
      tooltip-label {
          color: @on_surface;
          padding: 5px;
      }
      #clock:hover, #custom-pacman:hover, #custom-notification:hover,#bluetooth:hover,#network:hover,#battery:hover, #cpu:hover,#memory:hover,#temperature:hover{
          transition: all .3s ease;
          color: @tertiary;
      }
      #custom-notification {
          padding: 0px 5px;
          transition: all .3s ease;
          color: @on_surface;
      }
      #clock{
          padding: 0px 5px;
          color: @on_surface;
          transition: all .3s ease;
      }
      #custom-pacman{
          padding: 0px 5px;
          transition: all .3s ease;
          color: @on_surface;

      }
      #workspaces {
          padding: 0px 5px;
      }
      #workspaces button {
          all:unset;
          padding: 0px 5px;
          color: alpha(@primary,.4);
          transition: all .2s ease;
      }
      #workspaces button:hover {
          color:rgba(0,0,0,0);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
          transition: all 1s ease;
      }
      #workspaces button.active {
          color: @primary;
          border: none;
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }
      #workspaces button.empty {
          color: rgba(0,0,0,0);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
      }
      #workspaces button.empty:hover {
          color: rgba(0,0,0,0);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
          transition: all 1s ease;
      }
      #workspaces button.empty.active {
          color: @on_surface;
          border: none;
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }
      #bluetooth{
          padding: 0px 5px;
          transition: all .3s ease;
          color: @on_surface;

      }
      #network{
          padding: 0px 5px;
          transition: all .3s ease;
          color: @on_surface;

      }

      #custom-weather {
          padding: 0px 5px;
          transition: all .3s ease;
          color: @on_surface;
      }

      #battery{
          padding: 0px 5px;
          transition: all .3s ease;
          color: @on_surface;
      }
      #battery.charging {
          color: @tertiary;
      }

      #battery.warning:not(.charging) {
          color: @error;
      }

      #battery.critical:not(.charging) {
          color: @error_container;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      #group-expand{
          padding: 0px 5px;
          transition: all .3s ease; 
      }
      #custom-expand{
          padding: 0px 5px;
          color: alpha(@on_surface,.2);
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .7);
          transition: all .3s ease; 
      }
      #custom-expand:hover{
          color: rgba(255,255,255,.2);
          text-shadow: 0px 0px 2px rgba(255, 255, 255, .5);
      }
      #custom-colorpicker{
          padding: 0px 5px;
      }
      #cpu,#memory,#temperature{
          padding: 0px 5px;
          transition: all .3s ease; 
          color: @on_surface;

      }
      #custom-endpoint{
          color:transparent;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);

      }
      #tray{
          padding: 0px 5px;
          transition: all .3s ease; 

      }
      #tray menu * {
          padding: 0px 5px;
          transition: all .3s ease; 
      }

      #tray menu separator {
          padding: 0px 5px;
          transition: all .3s ease; 
      }
    '';
  };

  fonts.fontconfig.enable = lib.mkDefault true;
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
