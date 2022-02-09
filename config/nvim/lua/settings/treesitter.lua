local M = {}

M.setup = function()
  local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

  parser_configs.norg_meta = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main"
    },
  }

  parser_configs.norg_table = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main"
    },
  }

  require("nvim-treesitter.configs").setup({
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      ensure_installed = {"markdown", "java", "lua", "elm", "javascript", "norg", "ruby", "norg_table", "norg_meta"},
      highlight = {
        enable = true,
        disable = { "scala" },
      },
    })
  end

  require('neorg').setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {
        config = {
          icons = {
            heading = {
              enabled = true,

              level_1 = {
                enabled = true,
                icon = "◉",
              },
              level_2 = {
                enabled = true,
                icon = " ○",
              },
              level_3 = {
                enabled = true,
                icon = "  ●",
              },
              level_4 = {
                enabled = true,
                icon = "   ○",
              },
            },
          },
        },
      },
      ["core.norg.journal"] = {},
      ["core.integrations.telescope"] = {},
      ['core.keybinds'] = {
        config = {
          default_keybinds = true,
          neorg_leader = '<Space>o'
        }
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = "~/Writing/work",
            notes = "~/Writing/notes",
          }
        }
      },
    },
  }

return M
