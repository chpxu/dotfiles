{den, ...}: {
  den.aspects.productivity = {
     includes = [
      (den.batteries.insecure [
"firefox-esr-140-bin-unwrapped"
"firefox-esr-140-bin-unwrapped-140.17.0esr"
      ])
    ];

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
