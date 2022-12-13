let
  system = "x86_64-linux";
  user = "chunix";
  pkgs = nixpkgs.legacyPackages.${system};
  colour-palette = import ./home-manager/common/nordtheme.nix;
in {
  description = "My NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    nix-gaming,
    hyprland,
    hyprpaper,
    ...
  }: {
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    nixpkgs.config.allowUnfree = true;
    manual.manpages.enable = false;
    overlays = import ./overlays/waybar.nix;
    nixosConfigurations = rec {
      # Yoga
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./system/yoga/configuration.nix];
      };
      # Legion
      legion = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./system/legion/configuration.nix];
      };
    };

    homeConfigurations = {
      # yoga
      "${user}@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs colour-palette;};
        modules = [
          nur.nixosModules.nur
          hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland = {
              enable = true;
              extraConfig = (import ./modules/hyprland/hyprland.nix).extraConfig;
            };
          }
          ./packages/default.nix
          ./modules/default.nix
          ./home-manager/yoga/chunix/home.nix
          {
            home = {
              username = "chunix";
              homeDirectory = "/home/chunix";
              stateVersion = "22.05";
            };
          }
        ];
      };
      # legion
      "${user}@legion" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs colour-palette;
        };
        modules = [
          nur.nixosModules.nur
          hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland = {
              enable = true;
              extraConfig = (import ./modules/hyprland/hyprland.nix).extraConfig;
            };
          }
          ./packages/default.nix
          ./modules/default.nix
          ./home-manager/legion/chunix/home.nix
          {
            home = {
              username = "chunix";
              homeDirectory = "/home/chunix";
              stateVersion = "22.05";
            };
          }
        ];
      };
    };
  };
}
