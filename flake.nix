{
  description = "My NixOS setup";
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs.url = "github:nixos/nixpkgs";
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
    sops-nix, # TODO working on managing wireless secrets
    home-manager,
    nur,
    nix-gaming,
    hyprland,
    hyprpaper,
    xdph, # FIXME need to report issue on this
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    user = "chunix";
    colour-palette = import ./hm/common/nordtheme.nix;
    pkgs = nixpkgs.legacyPackages.${system};
  in rec {
    overlays = import ./overlays;
    nixosConfigurations = {
      # Yoga
      nixos = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          needsNvidia = false;
          needsIntel = true;
          hostname = "nixos";
        };
        modules = [
          ./system/yoga/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
        ];
      };
      # Legion
      legion = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          needsNvidia = true;
          needsIntel = true;
          hostname = "legion";
        };
        modules = [
          ./system/legion/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
        ];
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
              nvidiaPatches = true;
              systemdIntegration = true;
              recommendedEnvironment = true;
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
          # xdph
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
