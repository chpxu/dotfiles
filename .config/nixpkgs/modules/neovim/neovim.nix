{
  config,
  pkgs,
  ...
}: let
  paths = import ../../common/paths.nix;
  neovimPath = "${paths.modules}/neovim/lua";
  neovimPathConfig = "${neovimPath}/config";
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraConfig = ''
      colorscheme nord
      # lua package.path = package.path ..";/{neovimPath}/user-conf.lua;${neovimPath}/functions.lua"
      # luafile ${neovimPath}/user-conf.lua
      # luafile ${neovimPath}/functions.lua
      # luafile ${neovimPath}/options.lua
      # luafile ${neovimPath}/autocmd.lua
      # luafile ${neovimPath}/plugins.lua
      # lua << EOF
      # vim.defer_fn(function()
      #   vim.cmd [[
      #     luafile ${neovimPathConfig}/cmp.lua
      #     luafile ${neovimPathConfig}/colorizer.lua
      #     luafile ${neovimPathConfig}/git-blame.lua
      #     luafile ${neovimPathConfig}/gitsigns.lua
      #     luafile ${neovimPathConfig}/indent-blankline.lua
      #     luafile ${neovimPathConfig}/lsp.lua
      #     luafile ${neovimPathConfig}/luasnip.lua
      #     luafile ${neovimPathConfig}/navigator.lua
      #     luafile ${neovimPathConfig}/nord.lua
      #     luafile ${neovimPathConfig}/notify.lua
      #     luafile ${neovimPathConfig}/null-ls.lua
      #     luafile ${neovimPathConfig}/nvim-autopairs.lua
      #     luafile ${neovimPathConfig}/nvim-bqf.lua
      #     luafile ${neovimPathConfig}/nvim-tree.lua
      #     luafile ${neovimPathConfig}/todo-comments.lua
      #     luafile ${neovimPathConfig}/toggleterm.lua
      #     luafile ${neovimPathConfig}/treesitter.lua
      #     luafile ${neovimPathConfig}/which-keys.lua
      #     luafile ${neovimPathConfig}/telescope.lua

      #   ]]
      # end, 70)
      # EOF
    '';
    plugins = with pkgs.vimPlugins; [
      # Plugins are managed through here and files in ./neovim/
      packer-nvim
      # other plugin packages
      nvim-notify
      telescope-nvim
      telescope-symbols-nvim
      telescope-file-browser-nvim
      telescope-ui-select-nvim
      telescope-fzf-writer-nvim
      telescope-fzf-native-nvim
      telescope-project-nvim
      telescope-zoxide
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
        gcc
        git
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
