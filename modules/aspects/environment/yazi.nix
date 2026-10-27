_: {
  den.aspects.yazi = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.dragon-drop ];
        programs.yazi = {
          enable = true;
          enableZshIntegration = true;
          extraPackages = with pkgs; [
            dragon-drop
          ];
          shellWrapperName = "y";
          keymap = {
            mgr.prepend_keymap = [
              {
                on = [ "<C-n>" ];
                run = ''
                  shell --  dragon-drop -x -i -T "$1" --confirm
                '';
              }
            ];
          };
          plugins =
            let
              yp = pkgs.yaziPlugins;
            in
            {
              inherit (yp) git;
              inherit (yp) ouch;
              inherit (yp) mount;
              inherit (yp) starship;
              inherit (yp) rich-preview;
              inherit (yp) full-border;
            };
          settings = {
            mgr = {
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
            opener = {
              play = [
                {
                  run = ''mpv "$@"'';
                  orphan = true;
                  for = "unix";
                }
              ];
              edit = [
                {
                  run = ''"$EDITOR" "$@" '';
                  block = true;
                  for = "unix";
                }
              ];
              pic = [
                {
                  run = ''imv "$@" '';
                  orphan = true;
                  for = "unix";
                }
              ];
              open = [
                {
                  run = ''xdg-open "$@"'';
                  desc = "Open";
                }
              ];
              code = [
                {
                  run = ''code "$@"'';
                  desc = "Open in VSCode";
                }
              ];
            };

            open = {
               prepend_rules = [
    { url = "*.json"; use = "edit"; }
    { url = "*.sh";   use = "edit"; }
    { url = "*.toml"; use = "edit"; }
    { url = "*.y*ml"; use = "edit"; }
    { url = "*config"; use = "edit"; }
    { url = "*.cfg";  use = "edit"; }
    { url = "*env";   use = "edit"; }
    { url = "*.d";    use = "edit"; }
    { url = "*.md";   use = "edit"; }
    { url = "*.txt";  use = "edit"; }
    { url = ".zsh*";  use = "edit"; }
    { url = "*.ini";  use = "edit"; }
    { url = "*.lua";  use = "edit"; }
    { url = "*.xml";  use = "edit"; }
    { url = "*.log";  use = "edit"; }
    { url = "*.ods";  use = "open"; }
    { url = "*.pdf";  use = "open"; }
    { url = "*.mp3";  use = "play"; }
  ];
  append_rules = [
    { url = "*"; use = "code"; }
  ];
            };
          };
        };
      };
  };
}
