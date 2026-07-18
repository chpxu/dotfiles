{ den, ... }:
{
  den.aspects.gaming = {
    includes = [
      (den.provides.unfree [
        "steam"
        "steam-unwrapped"
        "osu-lazer-bin"
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
        programs.gamemode = {
          enable = true;
          enableRenice = true;
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
        {
          home.packages = [
            #(gamePkgs.osu-lazer-bin.override {
            #  releaseStream = "lazer";
            #})
            pkgs.osu-lazer-bin
          ];
        };
    };
  };
}
