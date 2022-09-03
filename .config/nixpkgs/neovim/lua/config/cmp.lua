-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- A comma separated list of options for Insert mode completion
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  enabled = true,
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      mode = "symbol",
      menu = {
        buffer = "BUF",
        rg = "RG",
        omni = "OMNI",
        nvim_lsp = "LSP",
        path = "PATH",
        luasnip = "SNIP",
        calc = "CALC",
        spell = "SPELL",
      },
    }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1
    
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "omni" },
    { name = "treesitter" },
    { name = "buffer" },
    { name = "luasnip", keyword_length = 2},
    { name = "calc" },
    { name = "spell", keyword_length = 3 },
    { name = "path" },
    { name = "rg", keyword_length = 3 },
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
