{
  config,
  pkgs,
  lib,
  builtins,
  needsNvidia ? true,
  needsIntel ? true,
  hostname,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import ../common/default.nix {
      inherit config builtins pkgs lib needsIntel needsNvidia hostname;
      needsScale = false;
    })
    (import ./modules/power/power.nix {inherit pkgs;})
  ];
  # systemd stuff
  systemd = {
    watchdog = {
      device = "/dev/watchdog";
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
