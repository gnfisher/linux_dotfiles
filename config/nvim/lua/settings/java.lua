local f = require("settings.functions")
local map = f.map

local function setup_java()
  map("n", "<leader>uo", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
  map("v", "<leader>ue", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
  map("n", "<leader>ue", "<Cmd>lua require('jdtls').extract_variable()<CR>")
  map("v", "<leader>um", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")

  map("n", "<leader>ro", "<cmd>lua require'dap'.repl.open()<CR>")
  map("n", "<leader>rc", "<cmd>lua require'dap'.repl.close()<CR>")
  map("n", "<leader>rl", "<cmd>lua require'dap'.run_last()<CR>")
  map("n", "<leader>rt", "<Cmd>lua require'jdtls'.test_class({ config = { console = 'console' } })<CR>")
  map("n", "<leader>rT", "<Cmd>lua require'jdtls'.test_nearest_method({ config = { console = 'console' } })<CR>")

  map("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>")
  map("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>")
  map("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>")
  map("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>")
  map("n", "<leader>rb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
  map("n", "<leader>rB", "require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
  map("n", "<leader>rL", "require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
end

return {
  setup_java = setup_java
}

