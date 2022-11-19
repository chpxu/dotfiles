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
      appimage-run
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
          repo = "xournalpp";
          rev = "8f44c87edf5367efc1f86f0ac8ab7234e98db214";
          sha256 = "sha256-wSP5BwluLDtScuK1/CuJUWbdTSJErNXUnlsECl7xbtU=";
        };
      }))
    ]
    ++ [
      pkgs.gamemode
      # inputs.nix-gaming.packages.${pkgs.system}.osu-stable
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
}
