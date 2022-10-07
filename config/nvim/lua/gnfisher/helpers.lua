local api = vim.api

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function trim_whitespace()
  local save = vim.fn.winsaveview()
  local cmd = 'keeppatterns %s/\\s\\+$//e'
  vim.api.nvim_command(cmd)
  vim.fn.winrestview(save)
end

local function jump_to_last_line()
  local ft = vim.bo.filetype
  local ln = vim.fn.line("'\"")
  local last_line = vim.fn.line("$")
  if ft ~= 'gitcommit' and ln > 0 and ln < last_line then
    vim.api.nvim_command([[:normal g`"]])
  end
end

return {
  map = map,
  trim_whitespace = trim_whitespace,
  jump_to_last_line = jump_to_last_line
}
