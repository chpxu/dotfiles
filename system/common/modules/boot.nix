{
  config,
  pkgs,
  lib,
  needsNvidia,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.devices = ["/dev/nvme0n1"];
      grub.theme = pkgs.nixos-grub2-theme;
      grub.efiSupport = true;
      grub.useOSProber = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["uinput" "acpi_call"] ++ lib.optional needsNvidia "nvidia";
    extraModulePackages = with config.boot.kernelPackages; [acpi_call] ++ lib.optional needsNvidia config.boot.kernelPackages.nvidiaPackages.beta;
    blacklistedKernelModules = ["nouveau"];
    kernelParams = ["ibt=off" "module_blacklist=nouveau" "i915.enable_psr=0" "i915.enable_fbc=1" "i915.fastboot=0" "i915.enable_dc=0" "i915.enable_guc=3"];
    initrd.supportedFilesystems = ["btrfs"];
    supportedFilesystems = ["ntfs" "btrfs"];
  };
}
