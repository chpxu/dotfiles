# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let  unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Import home-manager
    <home-manager/nixos>
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  # Use xanmod custom kernel
  boot.kernelPackages = unstable.linuxPackages_xanmod_latest;
  boot.kernelModules = [ "uinput"  "dpdk-kmods" ];

  # Define hostname
  networking.hostName = "nixos";
  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.wireless.networks = {
    lolNiceTry = {
      hidden = true;
      psk = "XDDDDDDDDDDDDDDD";
    };
  };
  # Set your time zone.
  time.timeZone = "UTC+1";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable PulseAudio sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # set environment variables
  environment.sessionVariables = rec { 
    #XDG_RUNTIME_DIR = "/run/user/$UID";
    NIXOS_OZONE_WL = "wayland"; 
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_WAYLAND = "wayland";
    BEMENU_BACKEND = "wayland";
    YDOTOOL_SOCKET = "/tmp/.ydotool_socket";
  }; 
   
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chunix = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "input" ]; # Enable ‘sudo’ for the user.
    shell = unstable.zsh;
   # packages = with pkgs; [];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano
    curl
    # GTK
    #unstable.gtk_engines
    #unstable.gtk-engine-murrine
    #unstable.gtk-layer-shell
    
    # glib
    unstable.glib
    unstable.glibc

    # MESA Graphics and Intel
    unstable.mesa
    unstable.libdrm
    unstable.intel-ocl
    unstable.intel-gmmlib
    #unstable.intel-media-sdk
    unstable.vaapiIntel
    unstable.intel-media-driver
    unstable.intel-compute-runtime
    #unstable.libplacebo
    #unstable.gegl
    #unstable.libGL
    unstable.libGLU
    unstable.libglvnd

    # Linux Kernels
    unstable.linuxKernel.kernels.linux_xanmod_latest
    
    # Audio
    unstable.rtkit
    unstable.pipewire
    unstable.wireplumber
    #unstable.alsa-firmware
    #unstable.alsa-ucm-conf
    #unstable.alsa-plugins
    #unstable.alsa-tools
    unstable.alsa-utils
    #unstable.alsa-lib
    
    home-manager
    unstable.pam
    unstable.dconf
    ydotool
    unstable.tlp
    unstable.libinput
    unstable.xdg-utils
    unstable.librsvg
    unstable.rPackages.rsvg
  ];
  
  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DejaVuSansMono" "DroidSansMono" "SourceCodePro" ]; })
    unstable.times-newer-roman
  ];
 
  # Manage zsh plugins via omz
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      #plugins = [ "zsh-syntax-highlighting" "zsh-autocomplete" "zsh-autosuggestions"];
      theme = "agnoster";
    };
  };
  gtk.iconCache.enable = true;
  xdg.icons.enable = true;
  programs = {
    waybar.enable = true;
    light.enable = true;
    dconf.enable = true;

    #Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  # RTKit
  security.rtkit.enable = true;
  services.udev.extraRules = ''
    KERNEL=="uinput", OPTIONS+="static_node=uinput", GROUP="input", MODE="0660"
  '';
  # PipeWire low latency and pipewire-pulse
  services.pipewire = {
    enable = true;
    alsa.enable = true;
   # alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 3048;
        "core.daemon" = true;
        "core-name" = "pipewire-0";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -11;
            "rt.prio" = 88;
            "rt.time.soft" = -1;
            "rt.time.hard" = -1;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-profiler"; }
        { name = "libpipewire-module-metadata"; }
        { name = "libpipewire-module-spa-device-factory"; }
        { name = "libpipewire-module-spa-node-factory"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-client-device"; }
        {
          name = "libpipewire-module-portal";
          flags = [ "ifexists" "nofail" ];
        }
        {
          name = "libpipewire-module-access";
          args = {};
        }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-link-factory"; }
        { name = "libpipewire-module-session-manager"; }
      ];
    };
    config.pipewire-pulse = {
      "context.properties" = {
        "log.level" = 2;
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -11;
            "rt.prio" = 88;
            "rt.time.soft" = -1;
            "rt.time.hard" = -1;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-metadata"; }
        {
          name = "libpipewire-module-protocol-pulse";
          args = {};
        }
      ];
      "stream.properties" = {
        "node.latency" = "32/48000";
        "resample.quality" = 4;
      };
      "pulse.properties" = {
        "server.address" = [ "unix:native" ];
      };
    };

  };
  services.tlp = {
    settings = {
      ENABLE = 1;
      TLP_WARN_LEVEL = 0;
      # Audio
      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      # Battery Care
      START_CHARGE_THRESH_BAT1 = 0;
      STOP_CHARGE_THRESH_BAT1 = 60;
      RESTORE_THRESHOLDS_ON_BAT = 1;
      NATACPI_ENABLE = 1;
      # Drive Bay - don't have one so all features on
      BAY_POWEROFF_ON_AC = 1;
      BAY_POWEROFF_ON_BAT = 1;
      # DIsks and Controllers
      DISK_APM_LEVEL_ON_AC = "254 254";
      DISK_APM_LEVEL_ON_BAT = "100 100";
      SATA_LINKPWR_ON_AC = "max_performance max_performance";
      SATA_LINKPWR_ON_BAT = "min_power min_power";
      AHCI_RUNTIME_PM_ON_AC = "on";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
      AHCI_RUNTIME_PM_TIMEOUT = 15;
      # Graphics
      INTEL_GPU_MIN_FREQ_ON_AC = 700;
      INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      INTEL_GPU_MAX_FREQ_ON_AC = 1100;
      INTEL_GPU_MAX_FREQ_ON_BAT = 1000;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1100;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 1000;
      # Kernel
      NMI_WATCHDOG = 0;
      # Networking
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      WOL_DISABLE = "Y";
      # Platform
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      # Processor
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      #CPU_HWP_ON_AC = "balance_performance";
      #CPU_HWP_ON_BAT = "power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0; 
      CPU_MAX_PERF_ON_BAT = 75;
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
      # Radio Device Switching - see rfkill also
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
      DEVICES_TO_DISABLE_ON_SHUTDOWN = "bluetooth wifi wwan";
      # Radio Device Wizard. Needs NetworkManager, but I don't have so irrelevant
      # Runtime Power Management and ASPM
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";
      # USB
      USB_AUTOSUSPEND = 0; # stops keyboard and mouse bugging out
      USB_EXCLUDE_AUDIO = 1;
      USB_EXCLUDE_BTUSB = 0;
      USB_EXCLUDE_PHONE = 0;
      USB_EXCLUDE_PRINTER = 1;
      USB_EXCLUDE_WWAN = 1;
    };
  };
  # OpenGL
  hardware.opengl = {
    enable = true;
    extraPackages = [ pkgs.mesa.drivers ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

