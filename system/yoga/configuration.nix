# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  builtins,
  needsNvidia ? false,
  needsIntel ? true,
  hostname,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import ../common/default.nix {
      inherit config builtins pkgs lib needsIntel needsNvidia hostname;
      needsScale = true;
    })
    # tlp
    ./tlp.nix
  ];

  # systemd stuff
  systemd = {
    watchdog = {
      device = "/dev/watchdog";
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chunix = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "input"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
