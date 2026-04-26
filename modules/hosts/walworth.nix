{
  den,
  ...
}:
{
  den.hosts.x86_64-linux.walworth.users.wally = {

  };
   den.aspects.walworth = {
    gpu = "nvidia";
    offload = false;
    wsl.enable = true;
    # host NixOS configuration
    includes = [
      den.aspects.boot
      den.aspects.console
      den.aspects.fonts
      den.aspects.networking
      den.aspects.security
      den.aspects.greeter
      den.aspects.overlays
    ];
    nixos = {pkgs, ...}: {
      boot.kernelPackages = pkgs.linuxPackages;
      boot.kernelModules = ["kvm-intel"];
      fileSystems."/lib/modules/6.6.87.2-microsoft-standard-WSL2" =
    { device = "none";
      fsType = "overlay";
    };
    fileSystems."/mnt/wsl" =
    { device = "none";
      fsType = "tmpfs";
    };
    fileSystems."/usr/lib/wsl/drivers" =
    { device = "drivers";
      fsType = "9p";
    };
    fileSystems."/" =
    { device = "/dev/disk/by-uuid/3b590d88-aabe-4ac5-badd-ba061af83b6a";
      fsType = "ext4";
    };
    fileSystems."/mnt/wslg" =
    { device = "none";
      fsType = "tmpfs";
    };

  fileSystems."/mnt/wslg/distro" =
    { device = "";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/usr/lib/wsl/lib" =
    { device = "none";
      fsType = "overlay";
    };

  fileSystems."/tmp/.X11-unix" =
    { device = "/mnt/wslg/.X11-unix";
      fsType = "none";
      options = [ "bind" ];
    };
    fileSystems."/mnt/c" =
    { device = "C:\134";
      fsType = "9p";
    };

  fileSystems."/mnt/wslg/doc" =
    { device = "none";
      fsType = "overlay";
    };

  fileSystems."/mnt/wslg/run/user/1000" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/36176f35-b085-4b3b-8110-c658aefd343d"; }
    ];
    };
    # provides.to-users = {

    # };
  };
}