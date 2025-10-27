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
    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    home-manager,
    hyprland,
    hyprland-plugins,
    nur,
    nix-gaming,
    ...
  } @ inputs: let
    inherit (self) outputs;
    colour-palette = import ./hm/common/nordtheme.nix;
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
      config.permittedInsecurePackages = [
        "electron-27.3.11"
        "dotnet-runtime-6.0.36"
        "dotnet-sdk-wrapped-6.0.428"
      ];
      #overlays = builtins.attrValues outputs.overlays;
    };
    mkSystemConfiguration = {
      needsNvidia,
      needsIntel,
      hostname,
      user,
    }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit nur inputs outputs needsIntel needsNvidia hostname user;
        };
        modules = [
          {nixpkgs.pkgs = pkgs;}
          ./system/${hostname}/configuration.nix
          #nixpkgs.nixosModules.readOnlyPkgs
          sops-nix.nixosModules.sops
          nur.modules.nixos.default
          hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users."${user}" = import ./hm/${user}/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs outputs colour-palette hostname;
            };
          }
        ];
      };
  in {
    #overlays = import ./overlays;
    nixosConfigurations = {
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
      saitama = mkSystemConfiguration {
        needsNvidia = true;
        needsIntel = false;
        hostname = "saitama";
        user = "chunix";
      };
    };
  };
}
