{
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 35;
      max-length = 20;
      # mode = "overlay";
      exclusive = false;
      ipc = true;
      passthrough = false;
      # margin-left = 2;
      # margin-right = 2;
      spacing = 0;
      modules-left = [
        "custom/launcher"
        "custom/keyboard"
        "hyprland/workspaces"
        "custom/separator"
        "tray"
      ];
      modules-center = [
        "wlr/taskbar"
      ];
      modules-right = [
        "idle_inhibitor"
        "pulseaudio"
        "bluetooth"
        "custom/mullvadvpn"
        "network"
        "cpu"
        "memory"
        "backlight"
        "battery"
        "hyprland/language"
        "clock"
        #"custom/poweroff"
      ];
      # Modules configuration
      "hyprland/workspaces" = {
        "format" = "{icon}";
        "format-icons" = {
          "11" = "1";
          "12" = "2";
          "13" = "3";
          "14" = "4";
          "15" = "5";
          "16" = "6";
          "17" = "7";
          "18" = "8";
          "19" = "9";
          "20" = "10";
          "21" = "1";
          "22" = "2";
          "23" = "3";
          "24" = "4";
          "25" = "5";
          "26" = "6";
          "27" = "7";
          "28" = "8";
          "29" = "9";
          "30" = "10";
        };
        on-scroll-up = "hyprctl dispatch split:workspace r+1";
        on-scroll-down = "hyprctl dispatch split:workspace r-1";
        "disable-scroll" = false;
        "persistent-workspaces" = { };
        on-click = "activate";
        "all-outputs" = false;
        "active-only" = false;
      };
      "wlr/taskbar" = {
        all-outputs = true;
        format = "{icon}";
        max-length = 20;
        icon-size = 20;
        icon-theme = "Nordzy";
        tooltip = false;
        tooltip-format = "{icon} {title}: {app_id}";
        on-click = "minimize-raise";
      };
      "hyprland/language" = {
        format = "  {}";
        # "format-en" = "ENG US";
        "format-en" = "ENG GB";
        keyboard-name = "at-translated-set-2-keyboard";
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
      bluetooth = {
        "format" = " {status}";
        "format-connected" = " {device_alias}";
        "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
        "format-device-preference" = [
          "device1"
          "device2"
        ];
        "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        "tooltip-format-connected" =
          "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        "tooltip-format-enumerate-connected-battery" =
          "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        on-click = "blueman-manager;";
      };
      tray = {
        icon-size = 20;
        spacing = 15;
        smooth-scolling-threshold = 1.0;
        show-passive-icons = true;
        # on-update = "makoctl invoke";
      };
      clock = {
        timezone = "GB";
        tooltip-format = "<big>{:%Y %B}</big>\n{calendar}";
        calendar-weeks-pos = "left";
        format-calendar = "<b>{}</b>";
        # format-calendar-weeks = "<span>Week: <i>{}</i></span>";
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
        interval = 60;
        states = {
          warning = 20;
          critical = 10;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-alt = "{time} {icon}";
        format-icons = [
          " "
          " "
          " "
          " "
        ];
      };
      network = {
        format-wifi = " {essid}";
        format-ethernet = " {essid}";
        tooltip-format = "SSID: {essid}\nInterface: {ifname} via {gwaddr}\nIP: {ipaddr}\nSubnetmask: {netmask}-{cidr}\nConnection Strength: {signalStrength}%\nFrequency: {frequency}GHz\nUp Speed: {bandwidthUpBits}\nDown Speed: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "(No Internet)";
        on-click = "hyprctl dispatch exec '[float]kitty -e nmtui'";
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
        on-click = "hyprctl dispatch exec '[float]pavucontrol'";
        tooltip = true;
        tooltip-format = "{icon} {desc}\nVolume: {volume}\n{format_source}";
      };
      "custom/launcher" = {
        # format = " ";
        format = "    ";
        background-image = "url('/home/chunix/.config/waybar/nixoslogo.svg')";
        on-click = "rofi -show drun";
        max-length = 50;
        tooltip = false;
      };
      "custom/separator" = {
        format = "|";
        tooltip = false;
      };
      "custom/keyboard" = {
        format = " ";
        tooltip = false;
        # exec = "exec $HOME/.config/waybar/wvkbd.sh";
        on-click = "exec $HOME/.config/waybar/wvkbd.sh";
        exec-on-event = false;
      };
      "custom/poweroff" = {
        format = "";
        tooltip = false;
        on-click = "poweroff";
        exec-on-event = false;
      };
      "custom/mullvadvpn" = {
        "interval" = 1;
        "format" = "{}";
        "exec" =
          "mullvad status -j | jq -r '.details.location.hostname' | grep -qF wg && echo 🔒 $(mullvad status -j | jq -r '.details.location.hostname') || echo 'VPN: D'";
        "max-length" = 100;
        "on-click" = "mullvad connect";
        "on-click-right" = "mullvad disconnect";
        "on-click-middle" = "mullvad-vpn";
        "tooltip-format" = "Left click: connect\nRight click: disconnect\nMiddle click: open gui";
      };
    };
  };
}
