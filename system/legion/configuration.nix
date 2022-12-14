# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
  nixpkgs.config.allowUnfree = true;

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Pipewire
    ../modules/pipewire.nix
    # tlp
    ../modules/tlp.nix
  ];
  fileSystems = {
    "/".options = ["compress-force=zstd:6"];
  };
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/nvme0n1";
      grub.theme = pkgs.nixos-grub2-theme;
      grub.efiSupport = true;
      grub.useOSProber = true;
    };
    # Kernel things
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelPackages = let
      rtVer = "14";
      xanmod = {
        fetchFromGitHub,
        buildLinux,
        ...
      } @ args:
        buildLinux (args
          // rec {
            version = "6.0.7";
            modDirVersion = "${version}-rt${rtVer}-xanmod1";
            src = fetchFromGitHub {
              owner = "xanmod";
              repo = "linux";
              rev = modDirVersion;
              sha256 = "sha256-4S1MMbGH1Q22S1UbmmvCkBiDhdbziroU9AZzhYgFcOg=";
            };
            kernelPatches = [];
            structuredExtraConfig = with lib.kernel; {
              EXPERT = yes;
              RCU_EXPERT = yes;
              # X86_PSTATE_DRIVER = yes;
              TCP_CONG_BBR2 = yes;
              DEFAULT_BBR2 = yes;
              NET_SCH_DEFAULT = yes;
              DEFAULT_FQ_PIE = yes;
              FUTEX = yes;
              FUTEX_PI = yes;
              WINESYNC = module;
              PREEMPT_RT = no;
              # PREEMPT_RT_FULL = yes;
              PREEMPT_VOLUNTARY = yes;
              LRU_GEN = yes;
              LRU_GEN_ENABLED = yes;
              DEBUG_OBJECTS = no;
              DEBUG_PREEMPT = no;
              NO_HZ = yes;
              # NO_HZ_IDLE = yes;
              # HZ = freeform "500";
              # HZ_500 = yes;
              # HZ_1000 = no;
              # RCU_PERF_TEST = no;
            };
            extraMeta.branch = "6.0";
          }
          // (args.argsOverride or {}));
      xanmodFor = pkgs.callPackage xanmod {};
    in
      pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor xanmodFor);
    kernelModules = ["uinput" "acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    initrd.supportedFilesystems = ["btrfs"];
    supportedFilesystems = ["ntfs" "btrfs"];
  };

  networking = {
    # Define hostname
    hostName = "legion";
    # Pick only one of the below networking options.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = true;
    wireless.scanOnLowSignal = false;
    wireless.environmentFile = "/run/p.env";
    # Easiest to use and most distros use this by default.
    # networking.networkmanager.enable = true;
    wireless.networks = {};
  };
  time.timeZone = "Europe/London";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod = {
      enabled = "ibus";
      uim.toolbar = "gtk";
      ibus = {
        engines = with pkgs.ibus-engines; [anthy];
      };
    };
    extraLocaleSettings = {
      LC_MESSAGES = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };
  console = {
    earlySetup = true;
    packages = with pkgs; [terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    keyMap = "us";
    #keyMap = "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  };

  # systemd stuff
  systemd = {
    watchdog = {
      device = "/dev/watchdog";
      runtimeTime = "10s";
      rebootTime = "1s";
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    services = {
      secrets = {
        script = ''
          if [ -L /run/p.env ]; then
            rm /run/p.env
          fi
          ln -s /home/chunix/git_projects/dotfiles/system/modified/p.env /run/p.env || exit 1
        '';
        wantedBy = ["multi-user.target"];
      };
      restartWPA = {
        script = ''
          systemctl restart wpa_supplicant.service
        '';
        wantedBy = ["default.target"];
        after = ["default.target"];
      };
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable PulseAudio sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;

  # set environment variables
  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_WAYLAND = "wayland";
    BEMENU_BACKEND = "wayland";
    CURL_CA_BUNDLE = "/etc/pki/tls/certs/ca-bundle.crt"; # try to fix curl cannot self-sign error
    LIBSEAT_BACKEND = "logind";
    XCURSOR_SIZE = "32";
    GDK_SCALE = "2";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chunix = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "input"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  # List packages installed in system profile.
  # Trying to keep as lean as possible.
  environment.systemPackages = with pkgs; [
    nano
    curl
    cacert
    tlp
    dconf
    linux-pam
    pciutils
    (pkgs.swaylock-effects.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "jirutka";
        repo = "swaylock-effects";
        rev = "b2736c5bef3add118183654305d05903c5947668";
        sha256 = "sha256-umxEwegKuJd/DUjaUQ88lbcQNxSY99yepBnQaFr3fDI=";
      };
    }))
    # nvidia-offload
  ];

  # Fonts
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      # caudex
      (
        nerdfonts.override {
          fonts = ["FiraCode" "DejaVuSansMono" "SourceCodePro"];
        }
      )
      pkgs.times-newer-roman
    ];
    fontconfig = {
      hinting = {
        enable = true;
        style = "hintmedium";
      };
      defaultFonts = {
        serif = ["Times Newer Roman"];
        monospace = ["FiraCode Nerd Font"];
        sansSerif = ["DejaVu Sans Mono"];
      };
    };
  };
  # zsh
  programs.zsh = {
    enable = true;
    #loginExtra = "betterdiscordctl --d-modules ~/.config/discordcanary/0.0.136/modules/ install";
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      customPkgs = with pkgs; [
        starship
      ];
    };
  };
  gtk.iconCache.enable = true;
  xdg = {
    icons.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        #		xdg-desktop-portal-gtk
      ];
      #gtkUsePortal = true;
    };
  };
  qt5 = {
    enable = true;
    style = "gtk2";
    platformTheme = "gtk2";
  };
  programs = {
    light.enable = true;
    dconf.enable = true;

    #Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nano = {
      syntaxHighlight = true;
      nanorc = ''
        set autoindent
        set afterends
        set atblanks
        set constantshow
        unset casesensitive
        set fill 80
        set linenumbers
        set minibar
        unset nowrap
        set softwrap
        set tabsize 2
      '';
    };
  };
  # RTKit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # PAM and swaylock
  security.pam.services.swaylock = {
    text = "auth include login";
  };
  # OpenGL
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    #uses beta drivers
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    nvidiaSettings = true;
    #Fixes a glitch
    nvidiaPersistenced = true;
    #Required for amdgpu and nvidia gpu pairings
    modesetting.enable = true;
    prime = {
      offload.enable = true;
      sync.enable = true;
      # FIXME: fix these bus IDs as appropriate
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      mesa.drivers
      libvdpau-va-gl
      vaapiVdpau
      nvidia-vaapi-driver
      libdrm
      libGLU
      libglvnd
    ];
  };
  hardware.cpu = {
    intel = {
      updateMicrocode = true;
      # sgx.provision.enable = true;
    };
  };
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.cpufreq.min = 300000;
  hardware.video.hidpi.enable = true;
  hardware.uinput.enable = true;
  hardware.opentabletdriver = {
    enable = true;
    package = pkgs.opentabletdriver;
    daemon.enable = true;
  };
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
