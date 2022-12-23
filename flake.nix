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
    mkHomeConfiguration = {
      extraSpecialArgs,
      hostname,
      isLegion,
      username,
      stateVersion,
      ...
    }:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          nur.nixosModules.nur
          hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland = {
              enable = true;
              nvidiaPatches = isLegion;
              systemdIntegration = true;
              recommendedEnvironment = true;
              extraConfig = (import ./hm/${hostname}/common/modules/hyprland/hyprland.nix).extraConfig;
            };
          }
          ./hm/common/packages
          ./hm/${hostname}/${username}/home.nix
          (import ./hm/common/packages/environment.nix {
            inherit pkgs isLegion;
          })
          ./hm/common/modules
          # (homeDetails {inherit username stateVersion;})
          {
            home = {
              inherit username stateVersion;
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };
    mkSystemConfiguration = {
      needsNvidia,
      needsIntel,
      hostname,
    }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs needsIntel needsNvidia hostname;
        };
        modules = [
          ./system/${hostname}/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
        ];
      };
  in {
    overlays = import ./overlays;
    nixosConfigurations = {
      # Yoga
      nixos = mkSystemConfiguration {
        needsNvidia = false;
        needsIntel = true;
        hostname = "nixos";
      };
      # Legion
      legion = mkSystemConfiguration {
        needsNvidia = true;
        needsIntel = true;
        hostname = "legion";
      };
    };

    homeConfigurations = {
      # Yoga
      "${user}@nixos" = mkHomeConfiguration {
        extraSpecialArgs = {inherit inputs outputs colour-palette;};
        hostname = "nixos";
        isLegion = false;
        username = user;
        stateVersion = "22.05";
      };
      # Legion
      "${user}@legion" = mkHomeConfiguration {
        extraSpecialArgs = {inherit inputs outputs colour-palette;};
        hostname = "legion";
        isLegion = true;
        username = user;
        stateVersion = "22.05";
      };
    };
  };
}
