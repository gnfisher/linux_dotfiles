local M = {}

M.setup = function()
  local cmp = require('cmp')
  cmp.setup {
    sources = {
      { name = "nvim_lsp", priority = 10 },
      { name = "buffer", keyword_length = 5 },
      { name = "vsnip" },
      { name = "path" },
      { name = "nvim_lua" },
    },
    snippet = {
      expand = function(args)
        -- Comes from vsnip
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert, }),
      ["<c-space>"] = cmp.mapping {
        i = cmp.mapping.complete(),
        c = function(
            _ --[[fallback]]
            )
          if cmp.visible() then
            if not cmp.confirm { select = true } then
              return
            end
          else
            cmp.complete()
          end
        end,
      },
      experimental = {
        -- native_menu = true,
      },
    }
  }
end

return M
