{
  pkgs,
  needsNvidia,
  ...
}: {
  imports = [
    # ./python/python.nix
    ./daily
    ./dev
    (import ./environment.nix {inherit pkgs needsNvidia;})
  ];
}
