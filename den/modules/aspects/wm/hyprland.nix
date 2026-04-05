{
  den,
  lib,
  inputs,
  ...
}: {
  # Sets up hyprland, the WM I use
  # den.ctx.user.includes = [den._.mutual-provider];
  # NixOS module should be enabled across all hosts
  den.aspects.hyprland = {
    nixos = {
      config,
      pkgs,
      ...
    }: {
      imports = [inputs.hyprland.nixosModules.default];
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };
    # Each host has slightly different configuration - mainly monitor and keybinds
    # provides.to-hosts = {host, ...}: {
    #   nixos.programs.nh.enable = host.name == "igloo";
    # };
    # homeManager = {
    #   config,
    #   pkgs,
    #   inputs,
    #   host,
    #   ...
    # }: {
    #   imports = [
    #     (import ./_hyprland/xdg.nix {
    #       inherit config pkgs inputs lib;
    #       hostname = host.hostName;
    #     })
    #   ];
    # };
  };
}
