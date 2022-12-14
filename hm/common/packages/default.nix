{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./python.nix
    ./applications.nix
  ];
}
