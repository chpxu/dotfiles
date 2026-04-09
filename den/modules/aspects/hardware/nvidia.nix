{
  den,
  lib,
  ...
}:
{
  den.aspects.hardware = den.lib.parametric {
    provides.nvidia =
      { gpu, ... }:
      lib.optionalAttrs (gpu == "nvidia") {
        nixos =
          { config, ... }:
          {
            services.xserver.videoDrivers = [
              "modesetting"
              "nvidia"
            ];
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
              videoAcceleration = true;
            };
          };
      };
    provides.nvidia-offload =
      { host, ... }:
      lib.optionalAttrs (host ? offload) {
        nixos = _: {
          hardware.nvidia.prime = {
            # Bus IDs set by nixos-hardware
            offload = {
              enable = true;
              enableOffloadCmd = true;
              offloadCmdMainProgram = "nvoff";
            };
          };
        };
      };
  };
}
