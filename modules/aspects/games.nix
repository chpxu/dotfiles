{ den, inputs, ... }:
{
  den.aspects.gaming = {
    includes = [
      (den.provides.unfree [
        "steam"
        "steam-unwrapped"
      ])
    ];
    nixos =
      {
        pkgs,
        lib,
        ...
      }:
      {

        programs.steam = {
          enable = lib.mkDefault false;
          remotePlay.openFirewall = lib.mkDefault false; # Open ports in the firewall for Steam Remote Play
          dedicatedServer.openFirewall = lib.mkDefault false;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };
    provides.minecraft = {
      homeManager =
        { pkgs, ... }:
        {
          home.packages = [ pkgs.prismlauncher ];
        };
    };
    provides.osu = {
      homeManager =
        { pkgs, ... }:
        let
          gamePkgs = inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system};
        in
        {
          home.packages = [
            gamePkgs.osu-lazer-bin
            gamePkgs.osu-stable
          ];
        };
    };
  };
}
