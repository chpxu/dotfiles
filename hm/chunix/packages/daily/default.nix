{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # thunderbird-wayland
    zotero_7
    logseq
    inkscape-with-extensions
    gimp
    bitwarden-cli
    libreoffice-fresh
    onedrive
    rnote
    pdfarranger
    yt-dlp
    wvkbd
    hyprpaper
    #obs-studio
    #mathpix-snipping-tool
    #davinci-resolve
    discord-canary
    remmina
    #libsForQt5.kdenlive
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
  ];
}
