{
  description = "My NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    home-manager,
    nur,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Basic data
    system = "x86_64-linux";
    user = "chunix";
    stateVersion = "22.11";
    colour-palette = import ./hm/common/nordtheme.nix;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
      config.permittedInsecurePackages = [
        "electron-27.3.11"
       "dotnet-runtime-6.0.36"
				"dotnet-sdk-wrapped-6.0.428"
      ];
      overlays = builtins.attrValues outputs.overlays;
    };
    nixosModules = import ./modules/nixos;
    mkSystemConfiguration = {
      needsNvidia,
      needsIntel,
      hostname,
      user,
    }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs nur inputs outputs needsIntel needsNvidia hostname user;
        };
        modules = [
          ./system/${hostname}/configuration.nix
          sops-nix.nixosModules.sops
          # nixosModules.VESTA
          #inputs.nix-gaming.nixosModules.pipewireLowLatency
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users."${user}" = import ./hm/${user}/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs outputs colour-palette;
            };
          }
        ];
      };
  in {
    overlays = import ./overlays;
    nixosConfigurations = {
      # Yoga
      yoga = mkSystemConfiguration {
        needsNvidia = false;
        needsIntel = true;
        hostname = "yoga";
        user = "chunix";
      };
      jingliu = mkSystemConfiguration {
        needsNvidia = true;
        needsIntel = true;
        hostname = "jingliu";
        user = "chunix";
      };
    };
  };
}
