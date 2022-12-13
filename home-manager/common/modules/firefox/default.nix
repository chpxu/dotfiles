{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
  inputs,
  outputs,
  ...
}: {
  imports = [./firefox.nix ./xdg.nix];
}
