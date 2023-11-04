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
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    home-manager,
    hyprland,
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
        "electron-24.8.6"
        "zotero-6.0.27"
      ];
      overlays = builtins.attrValues outputs.overlays;
    };
    # mkHomeConfiguration = {
    #   extraSpecialArgs,
    #   hostname,
    #   username,
    #   stateVersion,
    #   ...
    # }:
    #   home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs extraSpecialArgs;
    #     modules = [
    #       nur.nixosModules.nur
    #       {
    #         home = {
    #           inherit username stateVersion;
    #           homeDirectory = "/home/${username}";
    #         };
    #       }
    #       ./hm/common/commonHome.nix
    #       (import ./hm/common/packages/default.nix {
    #         inherit pkgs;
    #       })
    #       ./hm/common/modules
    #     ];
    #   };
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
          inputs.nix-gaming.nixosModules.pipewireLowLatency
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users."${user}" = import ./hm/${user}/home.nix;
            home-manager.extraSpecialArgs = {
              inherit
                inputs
                outputs
                colour-palette
                nur
                ;
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
      # Legion
      #legion = mkSystemConfiguration {
      # needsNvidia = true;
      #needsIntel = true;
      #hostname = "legion";
      #user = urser;
      #};
    };

    #homeConfigurations = {
    # Yoga
    # "${user}@yoga" = mkHomeConfiguration {
    #   extraSpecialArgs = {inherit inputs outputs colour-palette;};
    #   hostname = "yoga";
    #   needsNvidia = false;
    #   username = user;
    #   stateVersion = "22.11";
    # };
    # Legion
    #"${user}@legion" = mkHomeConfiguration {
    #  extraSpecialArgs = {inherit inputs outputs colour-palette;};
    #  hostname = "legion";
    #  needsNvidia = true;
    #  username = user;
    #  stateVersion = "22.11";
    #};
    #};
  };
}
