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
  imports = [./vscode.nix ./xdg.nix];
}
