{
  config,
  pkgs,
  lib,
  isLegion ? false,
  inputs,
  ...
}: {
  imports = [
    ./python/python.nix
    ./daily
    ./dev
    (import ./environment.nix {inherit pkgs isLegion;})
  ];
}
