local status_ok, config = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
  return
end

-- Mappings.
local opts = { noremap = true, silent = true }
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
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)
  vim.keymap.set('n', 'gR', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '==', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Give some borders to the hover/documentation popup
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

config.elmls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

config.html.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

config.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

config.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

if vim.fn.executable('srb') == 1 then
  config.sorbet.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "srb", "tc", "--lsp" }
  }
end

config.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local function metals_status_handler(_, status, ctx)
  -- https://github.com/scalameta/nvim-metals/blob/main/lua/metals/status.lua#L36-L50
  local val = {}
  if status.hide then
    val = { kind = "end" }
  elseif status.show then
    val = { kind = "begin", message = status.text }
  elseif status.text then
    val = { kind = "report", message = status.text }
  else
    return
  end
  local info = { client_id = ctx.client_id }
  local msg = { token = "metals", value = val }
  -- call fidget progress handler
  vim.lsp.handlers["$/progress"](nil, msg, info)
end

local handlers = {}
handlers['metals/status'] = metals_status_handler

local status_ok, metals = pcall(require, "metals")
if not status_ok then
  return
end
metals_config = metals.bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
  showImplicitArguments = true,
}
metals_config.on_attach = on_attach
metals_config.capabilities = capabilities
metals_config.handlers = handlers

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
