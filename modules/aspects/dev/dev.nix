{
  den,
  lib,
  inputs,
  ...
}:
{
  den.aspects.dev = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nil
          nixfmt
        ];
      };
    provides.neovim = {
      nixos = {
        programs.neovim = {
          withRuby = false;
          withPython3 = true;
        };
      };
      homeManager = _: {
        programs.neovide.enable = true;
        programs.neovim = {
          enable = true;
          defaultEditor = true;
        };
      };
    };
    provides.nvchad = {
      homeManager =
        { pkgs, ... }:
        {
          imports = [ inputs.nvchad.homeManagerModules.default ];
          programs.nvchad = {
            enable = true;
            extraPackages = with pkgs; [
              ripgrep
              nixfmt
              fortls
              fprettify
              vimPlugins.nvim-treesitter-parsers.typescript
              prettier
            ];
            chadrcConfig = ''
              local M = {}
              M.ui = {
                theme = "nord",
               transparency = true,
              }
              return M
            '';
            extraPlugins = builtins.readFile ./_nvchad/plugins.lua;
          };
        };
    };
    provides.vscode = {
      includes = [
        (den.provides.unfree [
          "vscode"
          "code"
        ])
      ];
      homeManager =
        { pkgs, ... }:
        {
          imports = [
            ./_vscode/xdg.nix
          ];
          programs.vscodium = {
            enable = true;
            package = pkgs.vscodium-fhs;
            mutableExtensionsDir = true;
            # profiles.default.extensions = (import ./_vscode/extensions.nix { inherit pkgs; }).extensions;
            # profiles.default.userSettings = (import ./_vscode/settings.nix).settings;
          };
        };
    };
    provides.helix = {
      homeManager =
        { pkgs, config, ... }:
        {
          programs.helix = {
            enable = true;
            package = pkgs.steelix;
            defaultEditor = true;
            settings = {
              theme = "nordic";
            };
          };
          xdg.configFile = {
            "nordic.toml" = {
              source = config.lib.file.mkOutOfStoreSymlink ./. + /nordic.toml;
              target = "${config.xdg.configHome}/helix/themes/nordic.toml";
            };
          };
        };
    };
    provides.zed = {
      homeManager =
        { pkgs, ... }:
        {
          programs.zed-editor = {
            enable = true;
            extensions = [
              "html"
              "css"
              "nix"
              "tmml"
              "make"
              "python"
              "fortran"
              "c"
              "cpp"
              "shell"
            ];

            # Everything inside of these brackets are Zed options
            userSettings = {
              assistant = {
                enabled = false;
              };

              node = {
                path = lib.getExe pkgs.nodejs;
                npm_path = lib.getExe' pkgs.nodejs "npm";
              };

              hour_format = "hour24";
              auto_update = false;

              terminal = {
                alternate_scroll = "off";
                blinking = "off";
                copy_on_select = true;
                dock = "bottom";
                detect_venv = {
                  on = {
                    directories = [
                      ".env"
                      "env"
                      ".venv"
                      "venv"
                    ];
                    activate_script = "default";
                  };
                };
                env = {
                  TERM = "kitty";
                };
                font_family = "FiraCode Nerd Font";
                font_features = null;
                font_size = 16;
                line_height = "comfortable";
                option_as_meta = false;
                button = false;
                shell = "system";
                # shell = {
                #   program = "zsh";
                # };
                toolbar = {
                  title = true;
                };
                working_directory = "current_project_directory";
              };

              lsp = {

                nix = {
                  binary = {
                    path_lookup = true;
                  };
                };
              };

              languages = { };
              vim_mode = true;

              # Tell Zed to use direnv and direnv can use a flake.nix environment
              load_direnv = "shell_hook";
              base_keymap = "VSCode";

              theme = {
                mode = "system";
                light = "Nord light";
                dark = "Nord";
              };

              show_whitespaces = "all";
              ui_font_size = 16;
              buffer_font_size = 16;
            };
          };
        };
    };
  };
}
