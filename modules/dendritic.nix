{ inputs, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  # other inputs may be defined at a module using them.
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    den.url = "github:denful/den/5df0987658d6e44268abba953406480e9f066928";
    flake-file.url = "github:vic/flake-file";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland/39d7e209c79d451efab1b21151d5938289da838d";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    nix-gaming.url = "github:fufexan/nix-gaming/";
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    cachy = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
    materials = {
      url = "github:chpxu/materials-flake";
    };
    nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #textfox.url = "github:adriankarlen/textfox";

  };
}
