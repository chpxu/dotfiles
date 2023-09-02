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
    })
    (import ./modules/power/power.nix {inherit pkgs;})
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chunix = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "input"]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$ZrsmB74qJZPIGnug4S9oK/$8oGAGKC3TYuo0nfouU9gzoIEjSS5c6rVtRcGye0QDf7";
    shell = pkgs.zsh;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
