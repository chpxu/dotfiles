{
  description = "My NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    home-manager,
    nur,
    nix-gaming,
    hyprland,
    hyprpaper,
    xdph,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    user = "chunix";
    colour-palette = import ./hm/common/nordtheme.nix;
    pkgs = nixpkgs.legacyPackages.${system};
  in rec {
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    nixpkgs.config.allowUnfree = true;
    manual.manpages.enable = false;
    overlays = import ./overlays;
    nixosConfigurations = {
      # Yoga
      nixos = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./system/yoga/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
      # Legion
      legion = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./system/legion/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
    };

    homeConfigurations = {
      # yoga
      "chunix@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs colour-palette;};
        modules = [
          nur.nixosModules.nur
          hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland = {
              enable = true;
              extraConfig = (import ./hm/yoga/common/modules/hyprland/hyprland.nix).extraConfig;
            };
          }
          ./hm/common/packages
          ./hm/yoga/chunix/home.nix
          (import ./hm/common/packages/environment.nix {
            inherit pkgs;
            isLegion = false;
          })
          ./hm/common/modules
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
              extraConfig = (import ./hm/legion/common/modules/hyprland/hyprland.nix).extraConfig;
            };
          }
          xdph.default
          ./hm/common/packages
          ./hm/legion/chunix/home.nix
          (import ./hm/common/packages/environment.nix {
            inherit pkgs;
            isLegion = true;
          })
          ./hm/common/modules
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
