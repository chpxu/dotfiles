{
  description = "My NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    # };
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    cachy = {
    	url = 
    	"github:xddxdd/nix-cachyos-kernel/"; 
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = 
    "github:fufexan/nix-gaming/849a92316e19aaba4a1618a9195ec637b59d81ee";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };

    materials = {
      url = "github:chpxu/materials-flake";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    cachy,
    hyprland,
    hyprland-plugins,
    hyprsplit,
    nur,
    nix-gaming,
    materials,
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
          {nixpkgs.pkgs = pkgs; nixpkgs.overlays = [cachy.overlay]; }
          
          ./system/${hostname}/configuration.nix
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
