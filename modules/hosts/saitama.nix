# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  den,
  ...
}:
{
  den.hosts.x86_64-linux.saitama.users.chunix = {

  };

  den.aspects.saitama = {

    # host NixOS configuration
    includes = [
      den.aspects.boot
      den.aspects.console
      den.aspects.fonts
      den.aspects.networking
      den.aspects.security
      den.aspects.graphics
      den.aspects.hardware
      den.aspects.hardware.provides.nvidia
      den.aspects.hardware.provides.nvidia-offload
      den.aspects.greeter
      den.aspects.sound
      den.aspects.disks
      den.aspects.time

      den.aspects.gaming

      (den.provides.unfree [
        "nvidia-x11"
        "nvidia-x11-610.43.02"
      ])
    ];
    nixos =
      { pkgs, config, ... }:
      {
        hardware.cpu.amd.updateMicrocode = true;
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
          # enabled = true;
          #branch = "stable";
          #package = config.boot.kernelPackages.nvidiaPackages.mkDriver {

           # version = "610.43.02";

            #sha256_64bit = "sha256:0qvllxnb20arjhw3bxdz0hw521di9ib75hldzx97gpscpdaa0d1h";

            #sha256_aarch64 = "sha256:0qvllxnb20arjhw3bxdz0hw521di9ib75hldzx97gpscpdaa0d1h";

            #openSha256 = "sha256-hP5NVZZ4vGsACHLmUDKq4uckpd/kn1GxCSYnnJfAuBs=";

            #settingsSha256 = "sha256-0YAhufRgjDW+uR+kjaTb154fibpcDw8QowfrucoZsKE=";

#            persistencedSha256 = "sha256-Whgv9X+v2fRhzliOl2LzltY9v1SxDafFfv3IUPqj/hk=";
  #        };
          powerManagement = {
            enable = true;
            finegrained = false;
            kernelSuspendNotifier = false;
          };
          open = true;
          nvidiaSettings = false;
          nvidiaPersistenced = true;
          modesetting.enable = true;
          dynamicBoost.enable = true;
          videoAcceleration = true;
        };
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
        fileSystems."/" = {
          device = "/dev/disk/by-uuid/3e86524a-64ec-4784-bb8f-61301a6586d9";
          fsType = "btrfs";
          options = [
            "noatime"
            "compress=zstd:3"
          ];
        };
        fileSystems."/extra" = {
          device = "/dev/disk/by-uuid/ee183dce-d512-41c3-a972-2aea109aa269";
          fsType = "btrfs";
          options = [
            "noatime"
            "compress=zstd:3"
          ];
        };
        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/5CA0-FBDD";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };
    provides.to-users.nixos = {
      programs.steam.enable = true;
    };
  };

}
