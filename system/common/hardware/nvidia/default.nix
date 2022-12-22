{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    #uses beta drivers
    package = config.boot.kernelPackages.nvidiaPackages.beta;
		powerManagement = {
			enable = true;
			finegrained = true;
		};
    #nvidiaSettings = true;
    nvidiaPersistenced = true;
    modesetting.enable = true;
    prime = {
      offload.enable = true;
      #sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
