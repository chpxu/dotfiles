{
  config,
  pkgs,
  ...
}: {
  imports = [./common/nordtheme.nix];
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-left = 2;
        margin-right = 2;
        spacing = 0;
        modules-left = [
          "custom/launcher"
          "custom/separator"
          "custom/keyboard"
          "custom/separator"
          "tray"
        ];
        modules-center = [
          "wlr/taskbar"
        ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "backlight"
          "battery"
          "clock"
        ];
        # Modules configuration
        "wlr/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };
        "wlr/taskbar" = {
          all-outputs = false;
          format = "{icon}";
          icon-size = 20;
          icon-theme = "Nordzy";
          tooltip = true;
          tooltip-format = "{icon} {app_id}";
          on-click = "minimize-raise";
        };
        idle_inhibitor = {
          format = "{icon} ";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = true;
          tooltip-format = "Sleep: {status}";
        };
        tray = {
          icon-size = 20;
          spacing = 15;
          smooth-scolling-threshold = 1.0;
          show-passve-icons = true;
        };
        clock = {
          timezone = "GB";
          tooltip-format = "<big>{:%Y %B}</big>\n{calendar}";
          calendar-weeks-pos = "left";
          format-calendar = "<b>{}</b>";
          format-calendar-weeks = "<span>Week: <i>{}</i></span>";
          format = " {:%H:%M  %Y-%m-%d}";
        };
        cpu = {
          format = " {usage}%";
          tooltip = true;
          tooltip-format = "{load}\n{usage}\n{avg_frequency}GHz";
        };
        memory = {
          format = " {percentage}%";
          tooltip = true;
          tooltip-format = "Used: {used}GiB/{total}GiB\nAvailable: {avail}GiB";
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          states = {
            warning = 20;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
          ];
        };
        network = {
          format-wifi = " {essid}";
          format-ethernet = " {essid}";
          tooltip-format = "SSID: {essid}\nInterface: {ifname} via {gwaddr}\nIP: {ipaddr}\nSubnetmask: {netmask}-{cidr}\nConnection Strength: {signalStrength}%\nFrequency: {frequency}GHz\nUp Speed: {bandwidthUpBits}\nDown Speed: {bandwidthDownBits}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "(No Internet)";
        };
        pulseaudio = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "M {format_source}";
          format-source = " {volume}%";
          format-source-muted = "M";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "kitty -e alsamixer";
          tooltip = true;
          tooltip-format = "{icon} {desc}\nVolume: {volume}\n{format_source}";
        };
        "custom/launcher" = {
          format = "";
          on-click = "wofi --show=run";
          max-length = 50;
          tooltip = false;
          tooltip-format = " wofi ";
        };
        "custom/separator" = {
          format = "|";
          tooltip = false;
        };
        "custom/keyboard" = {
          format = "";
          tooltip = false;
          on-click = "exec ~/.config/waybar/wvkbd.sh";
        };
      };
    };
    style = ''
      window#waybar {
          background: ${config.nordtheme.nord0};
          color: #eceff4;
          font-family: 'FiraCode Nerd Font', Inconsolata, sans-serif;
          font-weight: 700;
          font-size: 12px;
          border: none;
          border-radius: 0;
      }

      /*WORKSPACE STYLES*/
      #workspaces, #window {
          background: ${config.nordtheme.nord1};
          margin: 5px 0 5px 5px;
          border-radius: 5px;
      }
      #workspaces button {
          color: ${config.nordtheme.nord6};
          background: ${config.nordtheme.nord3};
          border: none;
          padding: 0 5px 0 5px;
          margin: 2.5px 2.5px 2.5px 2.5px;
      }
      #workspaces button:hover {
          border: none;
          background: ${config.nordtheme.nord1};
          box-shadow: none;
      }

      #workspaces button.focused {
          background: ${config.nordtheme.nord0};
      }
      #workspaces button.urgent {
          transition: background 0.5s ease-in-out;
          background: ${config.nordtheme.nord11};
      }
      #window {
          margin-left: 5px;
          color: ${config.nordtheme.nord15};
          padding-left: 5px;
          padding-right: 5px;
      }
      /*RIGHT-MODULES STYLES*/
      .modules-right {
          margin-right: 2.5px;
      }

      #cpu,
      #memory,
      #temperature,
      #backlight,
      #battery,
      #network,
      #state,
      #language,
      #tray,
      #clock,
      #idle_inhibitor,
      #pulseaudio,
      #custom-launcher,
      #custom-separator {
          /*border-right: #d8dee9 solid 1px;*/
          padding: 0 5px 0 5px;
          /* background: #3b4252; */
          margin: 5px 0 5px 0;
          border-radius: 5px;

      }

      #battery,
      #backlight {
          color: ${config.nordtheme.nord13};
      }
      #network {
          color: #88c0d0;
      }
      #cpu,
      #memory {
          color: ${config.nordtheme.nord9};
      }
      #clock,
      #tray {
          color: ${config.nordtheme.nord15};
      }
      #pulseaudio {
          color: ${config.nordtheme.nord10};
      }

      /*Tooltips*/
      tooltip {
          background: ${config.nordtheme.nord2};
          /* box-shadow: 1px 2px 5px #4c566a; */
          font-family: 'SauceCodePro Nerd Font', sans-serif;
          font-size: 16px;
          border-radius: 5px;
      }
      tooltip label {
          color: ${config.nordtheme.nord6};
      }

      /*Taskbar*/
      #taskbar button {
          border: none;
          color: ${config.nordtheme.nord6};
      }
      #taskbar button:hover {
          /*transition: background-color 0.125s ease-in-out;*/
          background-color: ${config.nordtheme.nord2};
      }
      #taskbar button.active {
          border-bottom: 2px solid #81a1c1;
          background-color: ${config.nordtheme.nord1};
      }
      .modules-left {
          margin-left: 2.5px;
      }
      /* Custom Module: Start Button for launcher  */
      #custom-launcher {
          color: ${config.nordtheme.nord10};
      }
      #custom-separator {
          color: ${config.nordtheme.nord4};
      }
    '';
  };
}
