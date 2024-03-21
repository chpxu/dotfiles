{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    #uses beta drivers
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    open = false;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    modesetting.enable = true;
    dynamicBoost.enable = true;
    prime = {
      offload.enable = true;
      enableOffloadCmd = true;
      #sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
