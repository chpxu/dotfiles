# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  den,
  ...
}:
{
  den.hosts.x86_64-linux.yoga.users.chunix = {

  };

  den.aspects.yoga = {

    # host NixOS configuration
    includes = [
      den.aspects.boot
      den.aspects.console
      den.aspects.fonts
      den.aspects.networking
      den.aspects.security
      den.aspects.graphics
      den.aspects.greeter
      den.aspects.sound
      den.aspects.disks
      den.aspects.time
      den.aspects.overlays
      den.aspects.power

    ];
    nixos =
      { pkgs, ... }:
      {
        hardware.cpu.intel.updateMicrocode = true;
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;
        boot.kernelModules = [ "kvm-intel" ];
        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "nvme"
          "usb_storage"
          "sd_mod"
        ];
        environment.etc = {
          "auto-cpufreq.conf" = {
            enable = true;
            source = ../aspects/power/auto-cpufreq.conf;
          };
          #"thermal-conf.xml" = {
          # enable = true;
          #source = ./thermal-conf.xml;
          #target = "thermald.xml";
          #};
        };
        fileSystems."/" = {
          device = "/dev/disk/by-uuid/495481ac-cf7d-4e04-a926-a038c1e2fe94";
          fsType = "btrfs";
          options = [
            "compress=zstd:3"
            "noatime"
          ];
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/8BDF-25E5";
          fsType = "vfat";
        };

        swapDevices = [
          { device = "/dev/disk/by-uuid/ca4e244c-c5ec-437e-aa1a-421113f052de"; }
        ];
      };
  };

}
