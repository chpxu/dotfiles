{ lib, ... }:
{
  den.aspects.systemd = {
    nixos = { };
    homeManager =
      { pkgs, ... }:
      {
        systemd.user.services = {
          onedrive = {
            Unit = {
              Description = "Run OneDrive Sync";
            };
            Service = {
              ExecStart = ''
                ${lib.getExe pkgs.onedrive} --synchronize
              '';
              Restart = "no";
              Type = "oneshot";
            };
            Install = {
              WantedBy = [ "multi-user.target" ];
            };
          };
        };
      };

  };
}
