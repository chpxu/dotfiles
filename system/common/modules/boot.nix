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
    kernelModules = ["uinput" "acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    kernelParams = ["ibt=off"];
    initrd.supportedFilesystems = ["btrfs"];
    supportedFilesystems = ["ntfs" "btrfs"];
  };
}
