set encoding=utf-8

let mapleader = " "

map <leader>s :so ~/.config/nvim/init.vim<CR>

set shell=/bin/sh
set nocompatible
set termguicolors
set list listchars=tab:▸\ ,trail:·,nbsp:·
set mouse=a
set belloff=all
set expandtab
set backspace=2   " Backspace deletes like most programs in insert mode
set tabstop=2 softtabstop=2 shiftwidth=2 " Default tab size
set nobackup
set nowritebackup
set noswapfile
set history=100
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000
set cursorline
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set hlsearch      " highlight the current search term 
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoread      " If a file is changed outside of vim automatically reload it without asking
set modelines=0   " Disable modelines as a security precaution
set nomodeline
set number
set relativenumber
set ruler
set colorcolumn=80
set signcolumn=number
set hidden
set showtabline=2 " Always show tabline
set ignorecase smartcase
set cmdheight=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set scrolloff=3
set wildmode=longest,list
set wildmenu
set nojoinspaces
set splitright
set splitbelow
set foldmethod=manual
set nofoldenable
set completeopt=menu,menuone,noselect
set spellfile=$HOME/.vim-spell-en.utf-8.add
set complete=.,w,b,u,t,i
set complete+=kspell
set path+=**
set diffopt+=vertical
set shortmess=c     " Try not showing any messages

filetype plugin indent on

augroup gnfisher
  autocmd!

  autocmd BufNewFile,BufRead *.ru setfiletype ruby
  autocmd BufNewFile,BufRead *.css.erb setfiletype css
  autocmd BufNewFile,BufRead *.mkd,*.md,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.json setfiletype javascript

  autocmd Filetype markdown setlocal spell textwidth=80
  autocmd Filetype gitcommit setlocal spell textwidth=76 colorcolumn=77
  autocmd FileType elm setlocal shiftwidth=4 tabstop=4

  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

call plug#begin()
  Plug 'lifepillar/vim-solarized8'
  Plug 'Shatur/neovim-ayu'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-github.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'RRethy/nvim-treesitter-endwise'
  Plug 'neovim/nvim-lspconfig'
  Plug 'scalameta/nvim-metals'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'onsails/lspkind.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'j-hui/fidget.nvim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'norcalli/nvim-terminal.lua'
  Plug 'mkitt/tabline.vim'
call plug#end()

" syntax on
set omnifunc=syntaxcomplete#Complete

set background=dark
color ayu
map <F6> :call ToggleBackground()<CR>

" Ruby configuration
let g:ruby_indent_block_style = 'do'
let g:ruby_indent_assignment_style = 'variable'

" Easier than "+
nmap cp "+y
nmap cv "+p
nmap cV "+P
vmap cp "+y
vmap cv "+p
vmap cV "+P

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

cnoremap <expr> %% expand('%:h').'/'

nnoremap <C-Space> <Esc>:noh<cr>

command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
nmap \ :Rg<SPACE>
nmap K :grep "\b<C-R><C-W>\b"<CR>:cw<CR>:redraw!<CR>

map <C-j> :cnext<CR>
map <C-k> :cprev<CR>

map <leader>gg :terminal gitsh<CR>

map <leader>ct :silent !ctags -R .<CR>:redraw!<CR>

map <leader>r :!ruby %:p<CR>

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({ previewer = false}))<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').loclist()<cr>

nnoremap <leader>gi <cmd>lua require('telescope').extensions.gh.issues()<cr>
nnoremap <leader>gp <cmd>lua require('telescope').extensions.gh.pull_request()<cr>

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

lua require('gnfisher.telescope.setup')
lua require('gnfisher.treesitter.setup')
lua require('gnfisher.lsp.completion')
lua require('gnfisher.lsp.setup')
lua require('fidget').setup{}
lua require('colorizer').setup()
lua require('terminal').setup()
lua require('ayu').setup({ mirage = false, })
lua require('lualine').setup({ options = { theme = 'ayu' }})

function! ToggleBackground()
    if &background == "light"
        set background=dark
    else
        set background=light
    endif
endfunction

highlight! BorderBG guibg=#ffffff guifg=#ffffff
