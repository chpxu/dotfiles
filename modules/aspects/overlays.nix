{ inputs, ... }:
{
  den.aspects.overlays = {
    nixos = _: {
      nixpkgs.overlays = [
        inputs.cachy.overlays.pinned
        (final: prev: {
          tuigreet = inputs.tuigreet.packages.${prev.hostPlatform.system}.tuigreet;
        })
      ];
    };
  };
}
