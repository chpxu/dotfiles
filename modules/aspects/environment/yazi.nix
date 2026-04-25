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
                {
                  name = "*.json";
                  use = "edit";
                }
                {
                  name = "*.sh";
                  use = "edit";
                }
                {
                  name = "*.toml";
                  use = "edit";
                }
                {
                  name = "*.y*ml";
                  use = "edit";
                }
                {
                  name = "*config";
                  use = "edit";
                }
                {
                  name = "*.cfg";
                  use = "edit";
                }
                {
                  name = "*env";
                  use = "edit";
                }
                {
                  name = "*.d";
                  use = "edit";
                }
                {
                  name = "*.md";
                  use = "edit";
                }
                {
                  name = "*.txt";
                  use = "edit";
                }
                {
                  name = ".zsh*";
                  use = "edit";
                }
                {
                  name = "*.ini";
                  use = "edit";
                }
                {
                  name = "*.lua";
                  use = "edit";
                }
                {
                  name = "*.xml";
                  use = "edit";
                }
                {
                  name = "*.log";
                  use = "edit";
                }
                {
                  name = "*.ods";
                  use = "open";
                }
                {
                  name = "*.pdf";
                  use = "open";
                }
                {
                  name = "*.mp3";
                  use = "play";
                }
              ];
              append_rules = [
                {
                  name = "*";
                  use = "code";
                }
              ];
            };
          };
        };
      };
  };
}
