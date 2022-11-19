{
  description = "Home Manager configuration of chpxu";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nur,
    nix-gaming,
    hyprland,
    hyprpaper,
    #firefox-nightly,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    nixpkgs.config.allowUnfree = true;

    homeConfigurations.chunix = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.

      modules = [
        nur.nixosModules.nur
        hyprland.homeManagerModules.default
        {
          # programs.hyprland.enable = true;
          wayland.windowManager.hyprland = {
            enable = true;
            extraConfig = (import ./modules/hyprland/hyprland.nix).extraConfig;
          };
        }
        ./packages/python.nix
        ./packages/environment.nix
        ./modules/default.nix
        ./home.nix

        {
          home = {
            username = "chunix";
            homeDirectory = "/home/chunix";
            stateVersion = "22.05";
          };
        }
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
