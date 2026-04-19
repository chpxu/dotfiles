{
  pkgs,
  inputs,
  ...
}:
{
  home.packages =
    with pkgs;
    let
      gamePkgs = inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system};
      materialPkgs = inputs.materials.packages.${pkgs.stdenv.hostPlatform.system};
    in
    [
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
      vesktop
      fastfetch
      bitwarden-desktop
      #hyprland-qtutils
      #libsForQt5.kdenlive
      (gamePkgs.osu-lazer-bin.override {
        releaseStream = "lazer";
      })
      materialPkgs.VESTA
      prismlauncher
      via
      filezilla
      lsfg-vk
      lsfg-vk-ui
      mangohud
    ];

}
