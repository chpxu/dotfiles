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
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix, # TODO work on pure secret evaluation
    home-manager,
    nur,
    nix-gaming,
    hyprland,
    hyprpaper,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    user = "chunix";
    colour-palette = import ./hm/common/nordtheme.nix;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
      overlays = builtins.attrValues outputs.overlays;
    };
    mkHomeConfiguration = {
      extraSpecialArgs,
      hostname,
      needsNvidia,
      username,
      stateVersion,
      ...
    }:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          nur.nixosModules.nur
          hyprland.homeManagerModules.default
          ./hm/${hostname}/${username}/home.nix
          (import ./hm/common/packages/default.nix {
            inherit pkgs needsNvidia;
          })
          (import ./hm/common/modules {
            inherit (nixpkgs) config;
            inherit pkgs colour-palette;
          })
          {
            wayland.windowManager.hyprland = {
              enable = true;
              nvidiaPatches = needsNvidia;
              systemdIntegration = true;
              recommendedEnvironment = true;
              extraConfig = (import ./hm/${hostname}/common/modules/hyprland/hyprland.nix).extraConfig;
            };
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
      "${user}@yoga" = mkHomeConfiguration {
        extraSpecialArgs = {inherit inputs outputs colour-palette;};
        hostname = "yoga";
        needsNvidia = false;
        username = user;
        stateVersion = "22.11";
      };
      # Legion
      "${user}@legion" = mkHomeConfiguration {
        extraSpecialArgs = {inherit inputs outputs colour-palette;};
        hostname = "legion";
        needsNvidia = true;
        username = user;
        stateVersion = "22.11";
      };
    };
  };
}
