local api = vim.api

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function split_on(s, delimiter)
  local result = {}
  local from = 1
  local delim_from, delim_to = string.find(s, delimiter, from)
  while delim_from do
    table.insert(result, string.sub(s, from, delim_from - 1))
    from = delim_to + 1
    delim_from, delim_to = string.find(s, delimiter, from)
  end
  table.insert(result, string.sub(s, from))
  return result
end

local function trim_whitespace()
  local save = vim.fn.winsaveview()
  local cmd = 'keeppatterns %s/\\s\\+$//e'
  vim.api.nvim_command(cmd)
  vim.fn.winrestview(save)
end

-- fun! TrimWhitespace()
--   let l:save = winsaveview()
--  keeppatterns %s/\s\+$//e
--   call winrestview(l:save)
-- endfun

return {
  map = map,
  split_on = split_on,
  trim_whitespace = trim_whitespace,
}
