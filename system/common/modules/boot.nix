{
  config,
  pkgs,
  lib,
  hostname,
  needsNvidia,
  ...
}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    kernelModules = ["uinput" "acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    blacklistedKernelModules = ["nouveau"];
    kernelParams = [
      "module_blacklist=nouveau"
      #"i915.enable_psr=0"
      #"i915.enable_fbc=1"
      #"i915.fastboot=0"
    ];
    initrd.supportedFilesystems = ["btrfs"];
    supportedFilesystems = ["ntfs" "btrfs"];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
    };
  };
}
