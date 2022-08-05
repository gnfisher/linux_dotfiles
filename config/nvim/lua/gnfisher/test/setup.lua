local status_ok, test = pcall(require, 'nvim-test')
if not status_ok then
  return
end
test.setup({
termOpts = {
  direction = 'horizontal',   -- terminal's direction ("horizontal"|"vertical"|"float")
  go_back = fals,          -- return focus to original window after executing
  stopinsert = 'auto',      -- exit from insert mode (true|false|"auto")
  keep_one = true,          -- keep only one terminal for testing
  },
})
