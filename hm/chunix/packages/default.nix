{pkgs, ...}: {
  imports = [
    ./daily
    ./dev
    ./environment.nix
  ];
}
