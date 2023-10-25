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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chunix = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "input" "disk"];
    hashedPassword = "$y$j9T$ZrsmB74qJZPIGnug4S9oK/$8oGAGKC3TYuo0nfouU9gzoIEjSS5c6rVtRcGye0QDf7";
    shell = pkgs.zsh;
  };
}
