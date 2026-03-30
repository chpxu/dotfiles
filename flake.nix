{
  description = "My NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    # };
    cachy = {
      url = "github:xddxdd/nix-cachyos-kernel/ea07123367e63d106bed7f1b6e964d444c808988";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming/";
    hyprland.url = "github:hyprwm/Hyprland/59f9f2688ac508a0584d1462151195a6c4992f99";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
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
    nixos-hardware,
    cachy,
    hyprland,
    hyprsplit,
    # nur,
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
          inherit inputs outputs needsIntel needsNvidia hostname user;
        };
        modules =
          [
            {
              nixpkgs.pkgs = pkgs;
              nixpkgs.overlays = [cachy.overlays.pinned];
            }
            ./system/${hostname}/configuration.nix
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
          ]
          ++ pkgs.lib.optionals (hostname
            == "jingliu") [nixos-hardware.nixosModules.lenovo-legion-16iah7h];
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
