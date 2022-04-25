set encoding=utf-8

let mapleader = " "

set nocompatible
set termguicolors
set list listchars=tab:▸\ ,eol:¬
set mouse=a
set belloff=all
set expandtab
set backspace=2   " Backspace deletes like most programs in insert mode
set tabstop=2 softtabstop=2 shiftwidth=2 " Default tab size
set nobackup
set nowritebackup
set noswapfile
set history=50
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
set signcolumn=no
set completeopt=menu,preview
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

  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

call plug#begin()
  Plug 'arcticicestudio/nord-vim'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dense-analysis/ale'
  Plug 'ElmCast/elm-vim'
call plug#end()

syntax on

set background=dark
color nord

" Ruby configuration
let g:ruby_indent_block_style = 'do'
let g:ruby_indent_assignment_style = 'variable'

" Easier than "+
nmap cp "+y
nmap cv "+p
nmap cV "+P

inoremap <C-@> <esc>
nnoremap <C-@> <esc>:nohlsearch<CR>

" Silent grep
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git\|node_modules$'
\ }

let g:elm_setup_keybindings = 0

nmap <silent> [r <Plug>(ale_previous_wrap)
nmap <silent> ]r <Plug>(ale_next_wrap)
let g:ale_open_list = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

nmap K :ALEHover<CR>
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences -quickfix<CR>

set omnifunc=ale#completion#OmniFunc

map <C-j> :cnext<CR>
map <C-k> :cprev<CR>

map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>g :silent !gitsh<CR>:redraw!<CR>
map <leader>ct :silent !ctags -R .<CR>:redraw!<CR>
