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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
