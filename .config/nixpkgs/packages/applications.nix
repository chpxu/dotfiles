{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  discordver = "0.0.140";
in {
  home.packages = with pkgs;
    [
      thunderbird-wayland
      betterdiscordctl
      inkscape-with-extensions
      gimp-with-plugins
      neofetch
      bitwarden
      teams
      libreoffice-fresh
      onedrive
      rnote
      pdfarranger
      yt-dlp
      texlive.combined.scheme-full
      ltex-ls
      osu-lazer
      (pkgs.discord-canary.overrideAttrs (oldAttrs: rec {
        version = discordver;
        src = fetchurl {
          url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
          sha256 = "sha256-AEbjkAMeOJ48RVgbVj35Rp26klCsCsDCX+VD5u1xCM0=";
        };
      }))
      (pkgs.wvkbd.overrideAttrs (oldAttrs: rec {
        src = fetchFromGitHub {
          owner = "chpxu";
          repo = "wvkbd";
          rev = "6ee1764535a06b9888242ad4a9c42a7ac9821791";
          sha256 = "TWd/CECWxZJ0WeFVjeuHWAq9fGKGOd6MLpjvzOpKGOo=";
        };
      }))
      (pkgs.xournalpp.overrideAttrs (oldAttrs: rec {
        src = fetchFromGitHub {
          owner = "chpxu";
          repo = "xournalpp1";
          rev = "0f9ff2d756cb59746b6a863fca25f5ee5318b0ce";
          sha256 = "sha256-w9kR7Qy6wRf7U6PmyUVpEuD5U1Lp+04FXHO/aCmDPrU=";
        };
      }))
    ]
    ++ [
      pkgs.gamemode
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
}
