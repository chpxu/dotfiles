{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # thunderbird-wayland
    betterdiscordctl
    inkscape-with-extensions
    gimp
    neofetch
    bitwarden-cli
    libreoffice-fresh
    onedrive
    rnote
    pdfarranger
    yt-dlp
    # obs-studio
    # mathpix-snipping-tool
  ];
}
