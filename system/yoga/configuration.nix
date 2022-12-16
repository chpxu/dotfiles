# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  needsNvidia ? false,
  needsIntel ? true,
  hostname,
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

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ../common/modules/default.nix {inherit hostname pkgs;})
      (import ../common/packages/default.nix {inherit pkgs needsNvidia needsIntel;})
      # tlp
      ./tlp.nix
      (import ../common/hardware/global {inherit pkgs;})
    ]
    ++ lib.optional needsNvidia ../common/hardware/nvidia
    ++ lib.optional needsIntel ../common/hardware/intel;
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
  console = {
    earlySetup = true;
    packages = with pkgs; [terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
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
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
