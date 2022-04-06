local M = {}

M.setup = function()
  local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

  require("nvim-treesitter.configs").setup({
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      ensure_installed = {"markdown", "java", "lua", "elm", "javascript", "ruby"},
      highlight = {
        enable = true,
        disable = { "scala" },
      },
    })
  end

return M
