{
  den,
  lib,
  inputs,
  ...
}:
{
  # Sets up hyprland, the WM I use
  # den.ctx.user.includes = [den._.mutual-provider];
  # NixOS module should be enabled across all hosts
  den.aspects.hyprland = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        environment.sessionVariables = {
          NIXOS_OZONE_WL = "wayland";
          EGL_PLATFORM = "wayland";
          WLR_NO_HARDWARE_CURSORS = "1";
        };
        imports = [ inputs.hyprland.nixosModules.default ];
        programs.hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };
      };
    # Each host has slightly different configuration - mainly monitor and keybinds
    homeManager =
      {
        config,
        pkgs,
        hostname,
        ...
      }:
      {
        imports = [
          (import ./_hyprland/xdg.nix {
            inherit
              config
              pkgs
              inputs
              lib
              hostname
              ;
          })
        ];
      };
  };
}
