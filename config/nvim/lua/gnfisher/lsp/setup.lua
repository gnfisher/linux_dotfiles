local status_ok, config = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
  return
end

local helpers = require('gnfisher.helpers')

-- Mappings.
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  map('n', 'gd', telescope.lsp_definitions, bufopts)
  map('n', 'gi', telescope.lsp_implementations, bufopts)
  map('n', 'gR', telescope.lsp_references, bufopts)
  map('n', 'gh', vim.lsp.buf.hover, bufopts)

  vim.keymap.set('n', '==', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end

config.elmls.setup{
  on_attach = on_attach
}

-- TODO: solargraph, html (with snippet completion), etc.
