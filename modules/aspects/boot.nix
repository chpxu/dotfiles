{lib, ...}: {
  den.aspects.boot = {
    nixos =
      { pkgs, ... }:
      {
        boot = {
          loader = {
            systemd-boot = {
              enable = true;
              configurationLimit = 10;
            };
            efi.canTouchEfiVariables = true;
          };
          kernelPackages = lib.mkDefault pkgs.linuxPackages;
          kernelModules = [
            "uinput"
            "acpi_call"
          ];
          # extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
          blacklistedKernelModules = [ "nouveau" ];
          kernelParams = [
            "module_blacklist=nouveau"
          ];
          initrd.supportedFilesystems = [ "btrfs" ];
          supportedFilesystems = [
            "ntfs"
            "btrfs"
          ];
          kernel.sysctl = {
            "fs.inotify.max_user_watches" = 524288;
          };
        };
      };
  };
}
