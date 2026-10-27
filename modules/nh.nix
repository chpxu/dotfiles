# Exposes flake apps under the name of each host / home for building with nh.
{
  den,
  ...
}:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
# Expose default devShell with nix stuff and a few others 
      devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ nixfmt nixd statix deadnix ];
        };

    };
}
