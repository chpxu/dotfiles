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
    })
    # tlp
    ./tlp.nix
  ];
}
