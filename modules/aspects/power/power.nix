{ lib, ... }:
{
  den.aspects.power = {
    nixos = _: {
      powerManagement.enable = false;
      services = {
        power-profiles-daemon.enable = false;
        auto-cpufreq.enable = lib.mkDefault true;
        thermald = {
          enable = lib.mkDefault true;
          # configFile = "/etc/thermald.xml";
        };
      };
    };

  };
}
