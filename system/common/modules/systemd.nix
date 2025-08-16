{
  systemd = {
    watchdog = {
      device = "/dev/watchdog";
    };
    #extraConfig = ''
    #  DefaultTimeoutStopSec=2s
   # '';
  };
}
