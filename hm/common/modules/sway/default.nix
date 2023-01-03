{
  config,
  pkgs,
  ...
}: {
  imports = [./swaylock_swayidle.nix ./xdg.nix];
}
