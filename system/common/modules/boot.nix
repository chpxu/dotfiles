{
  config,
  pkgs,
  ...
}: {
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.devices = ["/dev/nvme0n1"];
      grub.theme = pkgs.nixos-grub2-theme;
      grub.efiSupport = true;
      grub.useOSProber = true;
    };
    initrd = {
      kernelModules = ["nvidia"];
    };
    kernelModules = ["uinput" "acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    blacklistedKernelModules = ["nouveau"];
    kernelParams = ["ibt=off" "i915.enable_psr=0" "i915.enable_fbc=1" "i915.fastboot=0" "i915.enable_dc=0" "i915.enable_guc=3"];
    initrd.supportedFilesystems = ["btrfs"];
    supportedFilesystems = ["ntfs" "btrfs"];
  };
}
