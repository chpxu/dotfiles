{
  den,
  lib,
  ...
}:
{
  den.aspects.hardware = {

    provides.nvidia = _: {
      includes = [
        (den.provides.unfree [
          "nvidia-x11"
        ])
      ];
      nixos = _: {
        environment.variables = {
          LIBVA_DRIVER_NAME = "nvidia";
          NVD_BACKEND = "direct";
        };
        services.xserver.videoDrivers = [
          "modesetting"
          "nvidia"
        ];
        services.lact.enable = true;
        hardware.nvidia = {
          # enabled = lib.mkDefault false;
          branch = lib.mkDefault "stable";
          powerManagement = {
            enable = lib.mkDefault true;
            finegrained = lib.mkDefault false;
            kernelSuspendNotifier = lib.mkForce false;
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
      lib.optionalAttrs (host ? offload && host.offload) {
        nixos = _: {
          hardware.nvidia.prime = {
            # Bus IDs set by nixos-hardware or host
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
