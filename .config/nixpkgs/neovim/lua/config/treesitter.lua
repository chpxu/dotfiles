local enabled = {
  "c",
  "bash",
  "bibtex",
  "css",
  "gitignore",
  "javascript",
  "json",
  "jsonc",
  "html",
  "latex",
  "lua",
  "markdown",
  "nix",
  "regex",
  "scss",
  "yaml"
}
local disabled = { "" }
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = enabled,

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.ru
  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    use_languagetree = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  endwise = {
    enable = true,
  },
  indent = { enable = true },
  autopairs = { enable = true },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
      },
    },
  },
}
