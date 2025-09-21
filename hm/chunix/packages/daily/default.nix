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
    gimp3
    libreoffice-fresh
    onedrive
    rnote
    pdfarranger
    yt-dlp
    wvkbd
    #obs-studio
    #davinci-resolve
    #discord-canary
    vesktop
    #skypeforlinux
    # kdePackages.okular
    #ladybird
    #ghostty
    pfetch-rs
    bitwarden-desktop
    hyprland-qtutils
    #libsForQt5.kdenlive
    #inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
  ];
}
