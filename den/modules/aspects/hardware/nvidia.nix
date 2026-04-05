{
  hardware.nvidia = {
    nixos = {
      config,
      lib,
      ...
    }: {
      services.xserver.videoDrivers = ["modesetting" "nvidia"];
      hardware.nvidia = {
        package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
        powerManagement = {
          enable = lib.mkDefault true;
          finegrained = lib.mkDefault false;
        };
        open = true;
        nvidiaSettings = false;
        nvidiaPersistenced = lib.mkDefault true;
        modesetting.enable = true;
        dynamicBoost.enable = true;
      };
    };
  };
}
