{
  lib,
  den,
  inputs,
  ...
}:
{
  den.default.homeManager.home.stateVersion = "25.11";
  # den.default.nixos.modules.nixpkgs.overlays = [ inputs.cachy.overlay.pinned ];
  den.default.nixos = {
    system.stateVersion = "25.11";
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://nix-gaming.cachix.org"
          "https://hyprland.cachix.org"
          "https://attic.xuyh0120.win/lantian"
        ];
        trusted-substituters = [
          "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        ];
        auto-optimise-store = true;
      };
      optimise = {
        automatic = true;
        dates = [ "03:45" ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };
    };
  };
  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # host<->user provides
  den.ctx.user.includes = [ den._.mutual-provider ];
  # includes = [
  #   den.provides.define-user
  #   den.provides.hostname
  #   den.provides.inputs'
  #   den.provides.self'
  # ];

  # User TODO: REMOVE THIS
  # den.aspects.tux.nixos = {
  #   boot.loader.grub.enable = false;
  #   fileSystems."/".device = "/dev/fake";
  # };
}
