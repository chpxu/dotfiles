direnvSetup = {
 -- Path to the direnv executable
  bin = "direnv",

  -- Whether to automatically load direnv when entering a directory with .envrc
  autoload_direnv = false,

  -- Statusline integration
  statusline = {
    -- Enable statusline component
    enabled = true,
    -- Icon to display in statusline
    icon = "󱚟",
  },

  -- Keyboard mappings
  keybindings = {
    allow = "<Leader>da",
    deny = "<Leader>dd",
    reload = "<Leader>dr",
    edit = "<Leader>de",
  },

  -- Notification settings
  notifications = {
    -- Log level (vim.log.levels.INFO, ERROR, etc.)
    level = vim.log.levels.INFO,
    -- Don't show notifications during autoload
    silent_autoload = true,
  },  
}

local conformSetup = {
  formatters_by_ft = {
    -- Nix
    nix = { "nixfmt" },
    -- Fortran
    fortran = { "fprettify" },
    -- C / C++
    c   = { "clang_format" },
    cpp = { "clang_format" },
    -- Web (Vue 3 / TS / JS / CSS / JSON / Markdown)
    vue        = { "prettier" },
    typescript = { "prettier" },
    javascript = { "prettier" },
    css        = { "prettier" },
    html       = { "prettier" },
    json       = { "prettier" },
    jsonc      = { "prettier" },
    markdown   = { "prettier" },
    -- Lua (NvChad default formatter)
    lua = { "stylua" },
  },
 
  -- Format on save (remove if you prefer manual triggering)
  format_on_save = {
    lsp_fallback = true,
    timeout_ms   = 2000,
  },
}

return {
  {
  "NotAShelf/direnv.nvim",
  config = function()
    require("direnv").setup(direnvSetup)
  end,
  }  
}
