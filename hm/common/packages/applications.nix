{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs;
    [
      thunderbird-wayland
      betterdiscordctl
      inkscape-with-extensions
      gimp-with-plugins
      neofetch
      bitwarden-cli
      teams
      libreoffice-fresh
      onedrive
      rnote
      pdfarranger
      yt-dlp
      obs-studio
    ]
    ++ [
      # pkgs.gamemode
      # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
}
