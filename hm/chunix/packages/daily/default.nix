{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    thunderbird
    zotero
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
    #davinci-resolve
    #discord-canary
    vesktop
    #libsForQt5.kdenlive
    #inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
  ];
}
