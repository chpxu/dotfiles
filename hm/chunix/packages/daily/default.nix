{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # thunderbird-wayland
    zotero
    logseq
    inkscape-with-extensions
    gimp
    neofetch
    bitwarden-cli
    libreoffice-fresh
    onedrive
    rnote
    pdfarranger
    yt-dlp
    wvkbd
    hyprpaper
    obs-studio
    mathpix-snipping-tool
   #davinci-resolve
   discord-canary
   libsForQt5.kdenlive
  ];
}
