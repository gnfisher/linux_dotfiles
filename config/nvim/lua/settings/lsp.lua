local M = {}

M.setup = function()
  local lsp_config = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

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

  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  -- workspace dir needs to be an actual directory, not the directory where your project lives.
  -- you don't want ../your/code_dir/<project_name>/<jdtls configs>
  -- but instead .../your/workspaces/<project_name>/<jdtls_configs>
  local workspace_dir = '/home/greg/workspaces' .. project_name
  Jdtls_config = {
    cmd = {
      'java', -- or '/path/to/java11_or_newer/bin/java'
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', '/home/greg/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      '-configuration', '/home/greg/.local/share/jdtls/config_linux',
      '-data', workspace_dir,
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
      -- One dedicated LSP server & client will be started per unique root_dir
      root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

      -- Here you can configure eclipse.jdt.ls specific settings
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- for a list of options
      settings = {
        java = {
          -- format = {
          --   insertSpaces = vim.api.nvim_buf_get_option(bufnr, 'expandtab'),
          --   tabSize = vim.lsp.util.get_effective_tabstop(bufnr)
          -- },
          signatureHelp = { enabled = true },
          -- contentProvider = { preferred = 'fernflower' },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*"
            }
          },
          sources = {
            organizeImports = {
              starThreshold = 9999;
              staticStarThreshold = 9999;
            };
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            }
          },
          implementationCodeLens = { enabled = false };
          referenceCodeLens = { enabled = false };
        },
      },
    }

    local bundles = {
      vim.fn.glob("/home/greg/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
    };
    -- -- vim.list_extend(bundles, vim.split(vim.fn.glob("/home/greg/.local/share/vscode-java-test/server/*.jar"), "\n"))
    Jdtls_config['init_options'] = {
      bundles = bundles;
    }

    Jdtls_config['on_attach'] = function(client, bufnr)
      local jdtls = require('jdtls');
      jdtls.setup_dap({ hotcodereplace = 'auto' });
      jdtls.setup.add_commands();
    end

    Jdtls_config.on_init = function(client, _)
      if client.config.settings then
        client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
      end
    end

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    -- require('jdtls').start_or_attach(jdtls_config)
  end

  return M
