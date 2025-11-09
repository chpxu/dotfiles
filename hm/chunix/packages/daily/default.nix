{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; let
    gamePkgs = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
    materialPkgs = inputs.materials.packages.${pkgs.hostPlatform.system};
  in [
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
    pfetch-rs
    bitwarden-desktop
    hyprland-qtutils
    #libsForQt5.kdenlive
    (gamePkgs.osu-lazer-bin.override {
      releaseStream = "tachyon";
    })
    materialPkgs.VESTA
    prismlauncher
    via
  ];
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    extraPackages = with pkgs; [
      dragon-drop
    ];
    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["<C-n>"];
          run = ''
            shell --  dragon-drop -x -i -T "$1" --confirm
          '';
        }
      ];
    };
    plugins = let
      yp = pkgs.yaziPlugins;
    in {
      git = yp.git;
      ouch = yp.ouch;
      mount = yp.mount;
      starship = yp.starship;
      rich-preview = yp.rich-preview;
      full-border = yp.full-border;
    };
    settings = {
      manager = {
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
      };
    };
  };
}
