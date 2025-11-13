{
  config,
  pkgs,
  lib,
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
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelModules = ["uinput" "acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    blacklistedKernelModules = ["nouveau"];
    kernelParams =
      [
        "ibt=off"
        "module_blacklist=nouveau"
        #"i915.enable_psr=0"
        #"i915.enable_fbc=1"
        #"i915.fastboot=0"
      ]
      ++ lib.optional needsNvidia "NVreg_OpenRmEnableUnsupportedGpus=1";
    initrd.supportedFilesystems = ["btrfs"];
    supportedFilesystems = ["ntfs" "btrfs"];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
    };
  };
}
