{
  config,
  pkgs,
  lib,
  builtins,
  needsNvidia ? false,
  needsIntel ? true,
  hostname,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import ../common/default.nix {
      inherit
        config
        builtins
        pkgs
        lib
        needsIntel
        needsNvidia
        hostname
        ;
    })
    # power options
    ./power/power.nix
  ];
}
