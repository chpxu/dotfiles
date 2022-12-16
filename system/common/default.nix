{
  config,
  builtins,
  pkgs,
  lib,
  hostname,
  needsIntel,
  needsNvidia,
  needsScale,
  ...
}: {
  imports =
    [
      (import ./environment.nix {inherit needsScale;})
      (import ./modules/default.nix {inherit hostname config builtins lib pkgs;})
      (import ./packages/default.nix {inherit pkgs needsNvidia needsIntel;})
      (import ./hardware/global {inherit pkgs;})
    ]
    ++ lib.optional needsNvidia ./hardware/nvidia
    ++ lib.optional needsIntel ./hardware/intel;
}
