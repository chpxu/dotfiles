{pkgs}: {
  imports = [./tlp.nix];
  services = {
    auto-cpufreq.enable = true;
    thermald = {
      enable = true;
      configFile = "/etc/thermald.xml";
    };
  };
  environment.etc = {
    "auto-cpufreq.conf" = {
      enable = true;
      source = ./auto-cpufreq.conf;
    };
    "thermal-conf.xml" = {
      enable = true;
      source = ./thermal-conf.xml;
      target = "thermald.xml";
    };
  };
}
