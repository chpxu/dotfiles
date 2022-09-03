{
  config,
  pkgs,
  ...
}: {
  imports = [./common/nordtheme.nix];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraConfig = ''
      colorscheme nord
      lua package.path = package.path .. ";${config.xdg.configHome}/nixpkgs/neovim/lua/user-conf.lua;${config.xdg.configHome}/nixpkgs/neovim/lua/functions.lua"
      luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/user-conf.lua
      luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/functions.lua
      luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/options.lua
      luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/autocmd.lua
      luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/plugins.lua
      lua << EOF
      vim.defer_fn(function()
        vim.cmd [[
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/cmp.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/colorizer.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/git-blame.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/gitsigns.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/indent-blankline.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/lsp.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/luasnip.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/navigator.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/nord.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/notify.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/null-ls.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/nvim-autopairs.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/nvim-bqf.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/nvim-tree.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/telescope.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/todo-comments.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/toggleterm.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/treesitter.lua
          luafile ${config.xdg.configHome}/nixpkgs/neovim/lua/config/which-keys.lua

        ]]
      end, 70)
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      # Plugins are managed through here and files in ./neovim/
      packer-nvim
      # other plugin packages
      telescope-nvim
      telescope-symbols-nvim
      telescope-file-browser-nvim
      telescope-ui-select-nvim
      telescope-fzf-writer-nvim
      telescope-fzf-native-nvim
      toggleterm-nvim
    ];
    extraPackages = with pkgs.nodePackages;
      [
        neovim
        bash-language-server
        typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
      ]
      ++ (with pkgs.vimPlugins; [
        emmet-vim
        fzf-vim
        fzfWrapper
        nvim-fzf
      ])
      ++ (with pkgs; [
        tree-sitter
        nodejs
        texlab
        rnix-lsp
        sumneko-lua-language-server
        ripgrep
        fzf
      ]);
    # ++ [
    #   (import ./neovim/marksman.nix {
    #     })
    # ];
  };
}
