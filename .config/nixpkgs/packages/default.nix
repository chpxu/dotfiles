{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./packages/python.nix
    ./packages/environment.nix
    ./packages/applications.nix
  ];
}
