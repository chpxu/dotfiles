# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
rec {
	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
		};
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
        url = "https://github.com/nix-community/NUR/archive/1f80e16537599cff4c125eb306b0af827818e97c.tar.gz";
        sha256 = "1l28ds47xzn5aw8k6hg7j8arfq8pv22vpg6vy830ddwxa42jwwfv";
    }) {
      inherit pkgs;
    };
  };
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Import home-manager
    <home-manager/nixos>
    # Pipewire
    ./pipewire.nix
    # tlp
    ./tlp.nix
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  # Use xanmod custom kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest; 
  boot.kernelModules = [ "uinput"  "dpdk-kmods" "acpi_call" ];
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  # Define hostname
  networking.hostName = "nixos";
  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.wireless.networks = {
    yes = {
      hidden = true;
      psk = "nsfefew";
    };
  };
  # Set your time zone.
  time.timeZone = "UTC+8";

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

  # set environment variables
  environment.sessionVariables = rec { 
    #XDG_RUNTIME_DIR = "/run/user/$UID";
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
    extraGroups = [ "wheel" "audio" "video" "input" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  #home-manager.users.chunix = import /home/chunix/.config/nixpkgs/home.nix;
  #home-manager.users.chunix.nixpkgs.home-manager.useGlobalPkgs = true;
  # List packages installed in system profile.
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
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DejaVuSansMono" "SourceCodePro" ]; })
    pkgs.times-newer-roman
  ];
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
    };
    loginShellInit = "wayfire";
  };
  gtk.iconCache.enable = true;
  xdg.icons.enable = true;
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
  security.pam.services.swaylock = {};
 	security.polkit.enable = true;
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [ mesa.drivers libvdpau-va-gl vaapiVdpau 
    intel-ocl libdrm libGLU libglvnd intel-media-driver intel-compute-runtime 
    ];
  };
  hardware.cpu = {
		intel = {
			updateMicrocode = true;
			sgx.provision.enable = true;
		};
  };
  hardware.video.hidpi.enable = true;

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
