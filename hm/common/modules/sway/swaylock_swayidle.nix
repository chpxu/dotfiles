{
  config,
  pkgs,
  ...
}: {
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
      {
        event = "lock";
        command = "swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 60;
        command = "swaylock -fF";
      }
    ];
  };
  programs.swaylock.settings = {
    font = "FiraCode Nerd Font";
    font-size = 50;
    indicator-radius = 384;
    indicator-thickness = 75;
    inside-color = "ffffff00";
    key-hl-color = "5e81ac";
    ring-color = "2e3440";
    line-uses-ring = true;
    separator-color = "e5e9f022";
    text-color = "d8dee9ff";
    layout-text-color = "d8dee9ff";
    text-clear-color = "d8dee9ff";
    text-caps-lock-color = "d8dee9ff";
    indicator-idle-visible = true;
    daemonize = true;
    image = "${config.xdg.configHome}/swaylock/blue_swirl.png";
    scaling = "fill";
  };
}
