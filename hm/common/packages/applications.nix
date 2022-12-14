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
      # other applications may be in overlays
      discord
      waybar
      hyprpaper
    ]
    ++ [
      pkgs.gamemode
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
}
