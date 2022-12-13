{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./python.nix
    ./environment.nix
    ./applications.nix
  ];
}
