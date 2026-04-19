_: {
  den.aspects.productivity = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          thunderbird
          zotero
          logseq
          libreoffice-fresh
          onedrive
          rnote
          pdfarranger
          yt-dlp
          wvkbd
          #obs-studio
          vesktop
          fastfetch
          bitwarden-desktop
        ];
      };
  };
}
