local M = {}

M.setup = function()
  local lsp_config = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  })

  Metals_config = require("metals").bare_config()

  Metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
  }

  Metals_config.init_options.statusBarProvider = "on"
  Metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  Metals_config.on_attach = function(client, bufnr)
    vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])

    -- require("metals").setup_dap()
  end

  lsp_config.elmls.setup({})
  lsp_config.html.setup({})
  lsp_config.jsonls.setup({
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  })

  -- Uncomment for trace logs from neovim
  --vim.lsp.set_log_level('trace')
end

return M
