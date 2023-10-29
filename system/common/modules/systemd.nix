{
  systemd = {
    watchdog = {
      device = "/dev/watchdog";
    };
    extraConfig = ''
      DefaultTimeoutStopSec=5s
    '';
  };
}
