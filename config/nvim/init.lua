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
require("settings.treesitter").setup()

cmd([[syntax enable]])

g["mapleader"] = " "

global_opt.shortmess:remove("F"):append("c")
global_opt.termguicolors = true
global_opt.background = "light"
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 10
global_opt.showmatch = true
global_opt.laststatus = 2
global_opt.wildignore = { ".git", "*/node_modules/*", "*/target/*", ".metals", ".bloop", ".ammonite" }
global_opt.ignorecase = true
global_opt.smartcase = true
global_opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
global_opt.scrolloff = 5
global_opt.textwidth = 80
opt.spell = false
opt.path:append('**')
opt.wrap = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
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
opt.foldmethod = "manual"
opt.foldlevelstart = 0
opt.foldlevel = 99

-- Convenience
map("n", "<Leader>;", ":")
map("n", "<Leader>vr", ":luafile ~/.config/nvim/init.lua<CR>")
map("n", "<Leader>d", ":Dispatch<CR>")

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

-- Create new files with relative paths to open buffer
map("n", "<leader>ee", ":e <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
map("n", "<leader>et", ":tabe <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
map("n", "<leader>es", ":sp <C-R>=expand(\"%:p:h\") . \"/\" <CR>")
map("n", "<leader>ev", ":vsp <C-R>=expand(\"%:p:h\") . \"/\" <CR>")

-- LSP
g['prettier#config#print_width'] = 90 -- Java
g.neoformat_try_node_exe = 1
g.completion_matching_strategy_list = {
  "exact",
  "substring",
  "fuzzy",
}

map("n", "gD", [[<cmd>lua vim.lsp.buf.declaration()<CR>]])
map("n", "gd", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map("n", "<C-k>", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
map("n", "<leader>ds", [[<cmd>lua vim.diagnostic.setloclist()<CR>]]) -- buffer diagnostics only
map("n", "<leader>dn", [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
map("n", "<leader>dp", [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])
map("n", "<leader>dl", [[<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>]])
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map("n", "<leader>fr", [[<cmd>lua vim.lsp.buf.formatting({ tabSize = 2 })<CR>]])

map("n", "gr", [[<cmd>lua require"telescope.builtin".lsp_references()<CR>]])
map("n", "gds", [[<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>]])
map("n", "gws", [[<cmd>lua require"telescope.builtin".lsp_workspace_symbols({query = "*"})<CR>]])
map("n", "<leader>dw", [[<cmd>lua vim.lsp.diagnostic.set_loclist({workspace = true})<CR>]])

  -- require('telescope.builtin').diagnostics{prompt_prefix=" "}<CR>]])

-- Telescope
map("n", "<leader>tf", [[<cmd>lua require"telescope.builtin".find_files({layout_strategy="vertical"})<CR>]])
map("n", "<leader>tg", [[<cmd>lua require"telescope.builtin".live_grep({layout_strategy="vertical"})<CR>]])
map("n", "<leader>tw", [[<cmd>lua require"telescope.builtin".file_browser({layout_strategy="vertical"})<CR>]])
map("n", "<leader>td", [[<cmd>lua require"telescope.builtin".diagnostics{prompt_prefix=" "}<CR>]])
map("n", "<leader>tb", [[<cmd>lua require("telescope.builtin").buffers({layout_strategy="vertical"})<CR>]])
map("n", "<leader>tz", [[<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({layout_strategy="vertical"})<CR>]])
map("n", "<leader>mc", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])

-- Fugitive
g.github_enterprise_urls = {'https://git.hubteam.com'}
map("n", "<leader>gs", ":G<CR>")
map("n", "<leader>ga", ":Git fetch --all<CR>")
map("n", "<leader>gb", ":Git blame<CR>")
map("n", "<leader>gd", ":Gdiff<CR>")
map("n", "<leader>gj", ":diffget //3><CR>")
map("n", "<leader>gf", ":diffget //2><CR>")
map("n", "<leader>gp", ":Git push<CR>")

-- Commands
cmd(
  [[autocmd BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell]]
)
cmd([[autocmd BufReadPost,BufNewFile .html,*.txt,*.md,*.adoc set spell spelllang=en_us]])
cmd([[autocmd BufWritePost .rb lua require('lint').try_lint()]])
cmd([[autocmd TermOpen * startinsert]])
cmd([[autocmd BufWritePre * lua require('settings.functions').trim_whitespace()]])
cmd([[autocmd BufReadPost * lua require('settings.functions').jump_to_last_line()]])

-- LSP autocmd
cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala,java,lua setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach({})]])
cmd([[autocmd FileType ruby let b:dispatch = 'ruby %']])
cmd([[augroup END]])
