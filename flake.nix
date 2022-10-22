let
  system = "x86_64-linux";
in {
  description = "My NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hm = {
      url = "path:./.config/nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    hm,
    ...
  }: {
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    nixpkgs.config.allowUnfree = true;
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./system/modified/configuration.nix
      ];
    };
  };
}
