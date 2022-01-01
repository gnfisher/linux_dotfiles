local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local global_opt = vim.opt_global
local f = require("settings.functions")
local map = f.map

cmd([[packadd packer.nvim]])

require("plugins")
require("settings.cmp").setup()
require("settings.telescope").setup()
require("settings.lsp").setup()
require("settings.statusline")

require("nvim-treesitter.configs").setup({
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "scala" },
  },
})

cmd([[syntax enable]])
cmd([[colorscheme jellybeans-nvim ]])

g["mapleader"] = " "

local indent = 2

global_opt.shortmess:remove("F"):append("c")
global_opt.termguicolors = true
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 10
global_opt.showmatch = true
global_opt.laststatus = 2
global_opt.wildignore = { ".git", "*/node_modules/*", "*/target/*", ".metals", ".bloop", ".ammonite" }
global_opt.ignorecase = true
global_opt.smartcase = true
-- global_opt.clipboard = "unnamed"
global_opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
global_opt.scrolloff = 5
opt.wrap = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.expandtab = true
opt.fileformat = "unix"
opt.cmdheight = 2
opt.history = 10000
opt.list = true
opt.listchars = {tab = '»·', trail = '·', nbsp = '·'}
opt.splitright = true
opt.diffopt:append('vertical')
opt.cursorline = true
opt.fillchars = {vert = '|'}
opt.tags:prepend('.git/tags')
opt.exrc = true
opt.relativenumber = true
opt.number = true
opt.incsearch = true
opt.errorbells = false
opt.mouse = 'a'
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undodir = vim.env.HOME .. '/.vim/undodir'
opt.undofile = true
opt.autoread = true
opt.background = 'light'

-- statusline
-- opt.statusline = "%!luaeval('Super_custom_status_line()')"

--Mappings-
map("n", "<Leader>;", ":")
map("n", "<Leader>vr", ":luafile ~/.config/nvim/init.lua<CR>")

-- Copy paste helpers
map("n", "cp", "\"+y")
map("x", "cp", "\"+y")
map("n", "cv", "\"+p")
map("n", "cV", "\"+P")

-- <C-Space> behaves like escape in most modes.
map("n", "<C-Space>", "<Esc>:noh<CR>")
map("v", "<C-Space>", "<Esc>gV")
map("o", "<C-Space>", "<Esc>")
map("c", "<C-Space>", "<C-c>")
map("i", "<C-Space>", "<Esc>")

-- Remove wrapped lines.
map("n", "j", "gj")
map("n", "k", "gk")

-- Better window navigation.
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- Create new files with relative paths to open buffer
map("n", "<leader>e", ":e <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
map("n", "<leader>te", ":tabe <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
map("n", "<leader>se", ":sp <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
map("n", "<leader>ve", ":vsp <C-R>=expand(\"%:p:h\") . \"/\" <CR>")

-- LSP
g.completion_matching_strategy_list = {
  "exact",
  "substring",
  "fuzzy",
}
map("n", "gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "gds", [[<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>]])
map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
map("v", "K", [[<Esc><cmd>lua require("metals").type_of_range()<CR>]])
map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
map("n", "gds", [[<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>]])
map("n", "gws", [[<cmd>lua require"settings.telescope".lsp_workspace_symbols()<CR>]])
map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
map("n", "<leader>d", [[<cmd>lua vim.diagnostic.setloclist()<CR>]]) -- buffer diagnostics only
map("n", "<leader>nd", [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
map("n", "<leader>pd", [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])
map("n", "<leader>ld", [[<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>]])
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map("n", "<leader>fr", [[<cmd>lua vim.lsp.buf.formatting()<CR>]])

-- map("n", "<leader>ws", [[<cmd>lua require"metals".hover_worksheet()<CR>]])
-- map("n", "<leader>a", [[<cmd>lua require("metals").open_all_diagnostics()<CR>]])
-- map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
-- map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])

-- Telescope
map("n", "<leader>ff", [[<cmd>lua require"telescope.builtin".find_files({layout_strategy="vertical"})<CR>]])
map("n", "<leader>lg", [[<cmd>lua require"telescope.builtin".live_grep({layout_strategy="vertical"})<CR>]])
map("n", "<leader>fb", [[<cmd>lua require"telescope.builtin".file_browser({layout_strategy="vertical"})<CR>]])
map("n", "<leader>pd", [[<cmd>lua require"telescope.builtin".lsp_workspace_diagnostics{prompt_prefix=" "}<CR>]])
map("n", "<leader>mc", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
map("n", "<leader>ob", [[<cmd>lua require("telescope.builtin").buffers({layout_strategy="vertical"})<CR>]])
map("n", "<leader>fb", [[<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({layout_strategy="vertical"})<CR>]])

-- Fugitive
map("n", "<leader>gs", ":G<CR>")
map("n", "<leader>ga", ":Git fetch --all<CR>")
map("n", "<leader>gb", ":Gblame<CR>")
map("n", "<leader>gf", ":diffget //3><CR>")
map("n", "<leader>gj", ":diffget //2><CR>")

-- Commands
cmd([[autocmd FileType markdown setlocal textwidth=80]])
cmd(
  [[autocmd BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell]]
)
cmd([[autocmd BufReadPost,BufNewFile .html,*.txt,*.md,*.adoc set spell spelllang=en_us]])
cmd([[autocmd TermOpen * startinsert]])
cmd([[autocmd BufWritePre * lua require('settings.functions').trim_whitespace()]])
cmd([[autocmd BufReadPost * lua require('settings.functions').jump_to_last_line()]])

-- LSP
cmd([[augroup lsp]])
cmd([[autocmd!]])
 cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
 -- cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])
-- cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach({})]])
--cmd([[autocmd FileType dap-repl lua require("dap.ext.autocompl").attatch()]])
cmd([[augroup END]])

-- used in textDocument/hightlight
cmd([[hi! link LspReferenceText CursorColumn]])
cmd([[hi! link LspReferenceRead CursorColumn]])
cmd([[hi! link LspReferenceWrite CursorColumn]])

-- Diagnostic specific colors
cmd([[hi! DiagnosticError guifg=#e06c75]]) -- light red
cmd([[hi! DiagnosticWarn guifg=#e5c07b]]) -- light yellow
cmd([[hi! DiagnosticInfo guifg=#56b6c2]]) -- cyan
cmd([[hi! link DiagnosticHint DiagnosticInfo]])

-- _Maybe_ try underline for a bit
cmd([[hi! DiagnosticUnderlineError cterm=NONE gui=underline guifg=NONE]])
cmd([[hi! DiagnosticUnderlineWarn cterm=NONE gui=underline guifg=NONE]])
cmd([[hi! DiagnosticUnderlineInfo cterm=NONE gui=underline guifg=NONE]])
cmd([[hi! DiagnosticUnderlineHint cterm=NONE gui=underline guifg=NONE]])

-- Statusline specific highlights
-- cmd([[hi! StatusLine guifg=#5C6370 guibg=#282c34]])
-- cmd([[hi! link StatusError DiagnosticError]])
-- cmd([[hi! link StatusWarn DiagnosticWarn]])

-- Transparent backgrounds
cmd([[hi! Normal ctermbg=none guibg=none]])

-- cmd([[hi! TelescopeTitle guifg=#e5c07b]])

cmd([[autocmd TextYankPost * silent! lua vim.highlight.on_yank {}]])

fn.sign_define("DiagnosticSignError", { text = "▬", texthl = "DiagnosticError" })
fn.sign_define("DiagnosticSignWarn", { text = "▬", texthl = "DiagnosticWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "▬", texthl = "DiagnosticInfo" })
fn.sign_define("DiagnosticSignHint", { text = "▬", texthl = "DiagnosticHint" })

-- Since a lot of errors can be super long and multiple lines in Scala, I use
-- this to split on the first new line and only dispaly the first line as the
-- virtual text... that is when I actually use virtual text for diagnsostics
-- local diagnostic_foramt = function(diagnostic)
--   return string.format("%s: %s", diagnostic.source, f.split_on(diagnostic.message, "\n")[1])
-- end

--vim.diagnostic.config({ virtual_text = { format = diagnostic_foramt }, severity_sort = true })
--vim.diagnostic.config({ virtual_text = false })
