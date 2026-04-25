# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  den,
  inputs,
  ...
}:
{
  den.hosts.x86_64-linux.jingliu.users.chunix = {
  };

  den.aspects.jingliu = {
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
      den.aspects.hardware._.nvidia-offload
      den.aspects.overlays
      den.aspects.greeter
      den.aspects.sound
      den.aspects.disks
      den.aspects.time
    ];
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-hardware.nixosModules.lenovo-legion-16iah7h ];
        environment.systemPackages = with pkgs; [ brightnessctl ];
        networking.hostName = "jingliu";
        fileSystems."/" = {
          device = "/dev/disk/by-uuid/04f82933-1cfa-4758-9fbe-fa48d96677ec";
          fsType = "btrfs";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/60A8-85AE";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        swapDevices = [ ];
        hardware.cpu = {
          intel = {
            updateMicrocode = true;
          };
        };
      };
    gpu = "nvidia";
    offload = true;

    # host provides default home environment for its users
    # provides.to-users.homeManager = {pkgs, ...}: {
    #   home.packages = [
    #     pkgs.vim
    #     pkgs.btop-cuda
    #   ];
    # };
  };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user tux.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.tux = { };
  #   users.orca = { };
  # };
}
