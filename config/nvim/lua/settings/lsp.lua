local f = require("settings.functions")
local map = f.map

local M = {}

M.setup = function()

  local home = os.getenv('HOME')
  local lsp_config = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  lsp_config.tsserver.setup({})

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
      capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
    })

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  require'lspconfig'.sumneko_lua.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = {'vim'},
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

    require('lint').linters_by_ft = {
      ruby = {'ruby',}
    }

  end

  return M
