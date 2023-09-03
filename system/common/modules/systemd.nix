{
  systemd = {
    watchdog = {
      device = "/dev/watchdog";
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    user.services = {
      onedrive = {
        description = "Run OneDrive Sync";
        script = ''
          onedrive --synchronize
        '';
        wantedBy = ["default.target"];
      };
    };
  };
}
