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
      gimp
      neofetch
      bitwarden-cli
      teams
      libreoffice-fresh
      onedrive
      rnote
      pdfarranger
      yt-dlp
      # obs-studio
      masterpdfeditor4
      obsidian
      mathpix-snipping-tool
    ]
    ++ [
      # pkgs.gamemode
      # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
}
