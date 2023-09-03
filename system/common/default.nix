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
      ./hardware/global
      ./environment.nix
      (import ./modules/default.nix {inherit hostname config builtins lib pkgs;})
      (import ./packages/default.nix {inherit pkgs needsNvidia needsIntel;})
    ]
    ++ lib.optional needsNvidia ./hardware/nvidia
    ++ lib.optional needsIntel ./hardware/intel;
}
