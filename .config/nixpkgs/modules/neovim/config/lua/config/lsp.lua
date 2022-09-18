
local lspconfig = require("lspconfig")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())-- enable folding capabilities for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local servers = {
  "bashls",
  -- "clangd",
  "cssls",
  "emmet_ls",
  "eslint",
  "html",
  "jsonls",
  "marksman",
  "pyright",
  "sumneko_lua",
  "rnix",
  -- "terraformls",
  "texlab",
  -- "tsserver",
  "yamlls",
}
---
-- LSP Server configuration
---

-- Global Defaults
local defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
  "force",
  lspconfig.util.default_config,
  defaults
)
for _,lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = defaults.on_attach,
    flags = defaults.flags,
    autostart = true,
  }
end
lspconfig.texlab.setup({
  auxDirectory = ".",
  bibtexFormatter = "texlab",
  build = {
    args = {
      "-pdf",
      "-interaction=nonstopmode",
      "-synctex=1",
      "%f"
    },
    executable = "latexmk",
    forwardSearchAfter = false,
    onSave = false,
  },
  chktex = { onEdit = false, onOpenAndSave = false },
  diagnosticsDelay = 300,
  formatterLineLength = 80,
  forwardSearch = { args = {} },
  latexFormatter = "latexindent",
  latexindent = { modifyLineBreaks = false },
  capabilities = capabilities,
  on_attach = defaults.on_attach,

})
