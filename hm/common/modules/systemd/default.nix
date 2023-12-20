{pkgs, ...}: {
  # Set up USER systemd services here. Other config reserved for system config
  systemd.user.services = {
    onedrive = {
      Unit = {
        Description = "Run OneDrive Sync";
      };
      Service = {
        ExecStart = ''
          ${pkgs.onedrive} --synchronize
        '';
        Restart = "no";
        Type = "oneshot";
      };
      Install = {
        WantedBy = ["multi-user.target"];
      };
    };
  };
}
