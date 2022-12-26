{
  pkgs,
  isLegion ? false,
  ...
}: {
  imports = [
    ./python/python.nix
    ./daily
    ./dev
    (import ./environment.nix {inherit pkgs isLegion;})
  ];
}
