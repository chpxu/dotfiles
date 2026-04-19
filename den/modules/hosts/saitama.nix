# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  den,
  inputs,
  ...
}:
{
  den.hosts.x86_64-linux.saitama.users.chunix = {

  };

  den.aspects.saitama = {
    gpu = "nvidia";
    offload = false;

    # host NixOS configuration
    includes = [
      den.aspects.boot
      den.aspects.console
      den.aspects.fonts
      den.aspects.networking
      den.aspects.security
      den.aspects.graphics
      den.aspects.hardware
      den.aspects.hardware._.nvidia
      den.aspects.overlays
      den.aspects.greeter
      den.aspects.sound
      den.aspects.disks
      den.aspects.time
    ];
    nixos =
      { pkgs, ... }:
      {
        hardware.cpu.amd.updateMicrocode = true;
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

    # # # host provides default home environment for its users
    # provides.to-users.homeManager =
    #   { pkgs, ... }:
    #   {
    #     # home.packages = [
    #     #   # pkgs.fresh-editor
    #     # ];
    #   };
  };

}
