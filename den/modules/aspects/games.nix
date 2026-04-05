{den, ...}: {
  den.aspects.gaming = {
    nixos = {
      pkgs,
      lib,
      ...
    }: {
      programs.steam = {
        enable = lib.mkDefault false;
        remotePlay.openFirewall = lib.mkDefault false; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = lib.mkDefault false;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
      # home.packages = [
      #   inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
      # ];
    };
  };
}
