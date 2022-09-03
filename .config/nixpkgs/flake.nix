{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    nixpkgs.config.allowUnfree = true;

    homeConfigurations.chunix = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        nur.nixosModules.nur
        ./home.nix
        {
          home = {
            username = "chunix";
            homeDirectory = "/home/chunix";
            stateVersion = "22.05";
          };
        }
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
