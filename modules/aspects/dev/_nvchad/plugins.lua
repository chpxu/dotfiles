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

sh = { "shfmt" },
		bash = { "shfmt" },
		-- Nix
		nix = { "nixfmt" },
		-- Fortran
		fortran = { "fprettify" },
		-- C / C++
		c = { "clang_format" },
		cpp = { "clang_format" },
		-- Web (Vue 3 / TS / JS / CSS / JSON / Markdown)
		vue = { "prettier" },
		typescript = { "prettier" },
		javascript = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "prettier" },
		-- Lua (NvChad default formatter)
		lua = { "stylua" },
		typst = { "typstyle" },
	},

	-- Format on save (remove if you prefer manual triggering)
	format_on_save = {
    -- lsp_fallback = true	
lsp_format = "fallback",
		timeout_ms = 500,
	},
}

return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup(conformSetup)
		end,
	},
	{
		"NotAShelf/direnv.nvim",
		config = function()
			require("direnv").setup(direnvSetup)
		end,
	},
	{
  'andymass/vim-matchup',
  init = function()
    -- modify your configuration vars here
    vim.g.matchup_treesitter_stopline = 500

    -- or call the setup function provided as a helper. It defines the
    -- configuration vars for you
    require('match-up').setup({
      treesitter = {
        stopline = 500
      }
    })
  end,
  -- or use the `opts` mechanism built into `lazy.nvim`. It calls
  -- `require('match-up').setup` under the hood
  ---@type matchup.Config
  opts = {
    treesitter = {
      stopline = 500,
    }
  }
},
{
		"danymat/neogen",
		cmd = "Neogen",
		opts = {},
	},
	{

		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"tinymist",
			},
		},
	},
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {
			debug = false,
			open_cmd = "firefox-devedition %s -P typst-preview --class typst-preview",
			dependencies_bin = {
				tinymist = "@TINYMIST_PATH@",
				websocat = "@WEBSOCAT_PATH@",
			},
		}, -- lazy.nvim will implicitly calls `setup {}`
	},
}
