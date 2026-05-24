{ den, inputs, ... }:
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
      homeManager = {pkgs, ...}: {
        imports = [inputs.nvchad.homeManagerModules.default];
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
  };
}
