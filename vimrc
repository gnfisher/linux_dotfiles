syntax on

let mapleader = " "

set encoding=utf-8
set shell=/bin/sh
set term=screen-256color
set nocompatible
set list listchars=tab:▸\ ,trail:·,nbsp:·
set mouse=a
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
set number
set relativenumber
set colorcolumn=100
set signcolumn=number
set hidden
set showtabline=2 " Always show tabline
set ignorecase smartcase
set wildmenu
set wildmode=longest,list
set nojoinspaces
set splitright
set splitbelow
set completeopt=menu,preview
set spellfile=$HOME/.vim-spell-en.utf-8.add
set complete=.,w,b,u,t,i
set complete+=kspell
set path+=**
set diffopt+=vertical
set shortmess=c     " Try not showing any messages
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000


filetype plugin indent on

augroup gnfisher
  autocmd!

  autocmd BufNewFile,BufRead *.ru setfiletype ruby
  autocmd BufNewFile,BufRead *.css.erb setfiletype css
  autocmd BufNewFile,BufRead *.mkd,*.md,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.json setfiletype javascript

  autocmd Filetype markdown setlocal spell textwidth=100
  autocmd Filetype gitcommit setlocal spell textwidth=76 colorcolumn=77

  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

call plug#begin()
  Plug 'altercation/vim-colors-solarized'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
  Plug 'leafgarland/typescript-vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-dispatch'
  Plug 'vim-test/vim-test'
call plug#end()

set background=dark
color solarized

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

inoremap <C-@> <esc>
nnoremap <C-@> <esc>:nohlsearch<CR>

cnoremap <expr> %% expand('%:h').'/'

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif

command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
nmap \ :Rg<SPACE>
nmap K :grep "\b<C-R><C-W>\b"<CR>:cw<CR>:redraw!<CR>

let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git\|node_modules\|target$'
\ }

set omnifunc=ale#completion#OmniFunc
nmap <silent> [r <Plug>(ale_previous_wrap)
nmap <silent> ]r <Plug>(ale_next_wrap)
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences -quickfix<CR>
let g:ale_fixers = {
      \  'javascript': ['prettier'],
      \  'typescript': ['prettier'],
      \}
let g:ale_fix_on_save = 1

let test#strategy = "dispatch"

map <C-j> :cnext<CR>
map <C-k> :cprev<CR>
map <F2> :cnext<CR>
map <F6> :call ToggleBackground()<CR>

map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>g :silent !gitsh<CR>:redraw!<CR>
map <leader>ct :silent !ctags -R .<CR>:redraw!<CR>
map <leader>cT :CtrlPTag<CR>
map <leader>r :!ruby %:p<CR>

function! ToggleBackground()
    if &background == "light"
        set background=dark
    else
        set background=light
    endif
endfunction
