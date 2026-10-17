_: {
  den.aspects.productivity = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          thunderbird
          zotero
          logseq
          libreoffice
          onedrive
          pdfarranger
          yt-dlp
          wvkbd
          fastfetch
          bitwarden-desktop
        ];
      };
  };
}
