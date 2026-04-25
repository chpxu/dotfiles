{ inputs, den, ... }:
{
  den.aspects.overlays = {
    nixos =
      { ... }:
      {
        nixpkgs.overlays = [
          inputs.cachy.overlays.pinned
        ];
      };
  };
}
