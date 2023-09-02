{
  config,
  builtins,
  pkgs,
  lib,
  hostname,
  needsIntel,
  needsNvidia ? false,
  ...
}: {
  imports =
    [
      ./environment.nix
      (import ./modules/default.nix {inherit hostname config builtins lib pkgs;})
      (import ./packages/default.nix {inherit pkgs needsNvidia needsIntel;})
      (import ./hardware/global {inherit pkgs;})
    ]
    ++ lib.optional needsNvidia ./hardware/nvidia
    ++ lib.optional needsIntel ./hardware/intel;
}
