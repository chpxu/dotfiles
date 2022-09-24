# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: rec {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
  nixpkgs.config.allowUnfree = true;

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Import home-manager
    <home-manager/nixos>
    # Pipewire
    ./modules/pipewire.nix
    # tlp
    ./modules/tlp.nix
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
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["uinput" "acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    initrd.supportedFilesystems = ["btrfs"];
    supportedFilesystems = ["ntfs" "btrfs"];
  };
  networking = {
    # Define hostname
    hostName = "nixos";
    # Pick only one of the below networking options.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = true;
    # Easiest to use and most distros use this by default.
    # networking.networkmanager.enable = true;
    wireless.networks = {
    };
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
    packages = with pkgs; [
      terminus_font
    ];
    font = "ter-i32n";
    #keyMap = "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  };

  # systemd stuff
  systemd = {
    watchdog.rebootTime = "0s";
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
    home-manager
    tlp
    dconf
    linux-pam
    swaylock-effects
  ];

  # Fonts
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
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
        serif = "Times Newer Roman";
        monospace = "FiraCode Nerd Font";
        sansSerif = "DejaVu Sans Mono";
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
  };
  gtk.iconCache.enable = true;
  xdg = {
    icons.enable = true;
    #portal = {
    #	enable = true;
    #	extraPortals = with pkgs; [
    #		xdg-desktop-portal-wlr
    #		xdg-desktop-portal-gtk
    #	];
    #gtkUsePortal = true;
    #};
  };
  # sddm??
  #services.xserver.enable = true;
  #services.xserver.displayManager.sddm = {
  #	enable = true;
  #	enableHidpi = true;
  #	settings = {
  #		General = {
  #			DisplayServer = "wayland";
  #			GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
  #			InputMethod = "ibus";
  #		};
  #		Wayland = {
  #			CompositorCommand = "wayfire";
  #		};
  #	};
  #	theme = "";
  #};
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
        set mouse
        unset nowrap
        set softwrap
        set tabsize 2
      '';
    };
  };
  # RTKit
  security.rtkit.enable = true;
  # PAM and swaylock
  security.pam.services.swaylock = {
    text = "auth include login";
  };
  security.polkit.enable = true;
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      mesa.drivers
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
      intel-ocl
      libdrm
      libGLU
      libglvnd
      intel-media-driver
      intel-compute-runtime
    ];
  };
  hardware.cpu = {
    intel = {
      updateMicrocode = true;
      sgx.provision.enable = true;
    };
  };
  hardware.video.hidpi.enable = true;
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
