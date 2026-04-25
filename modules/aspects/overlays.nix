{ inputs, ... }:
{
  den.aspects.overlays = {
    nixos = _: {
      nixpkgs.overlays = [
        inputs.cachy.overlays.pinned
      ];
    };
  };
}
