" set leader
let mapleader = " "

" Backspace deletes like most programs in insert mode
set backspace=2
" allow unsaced backgroudn buffers and remember their undo/marks
set hidden
set undofile
set undodir=~/.config/nvim/undodir
set nowritebackup
" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noswapfile
set history=10000
set autoread
" Automatically :write before running commands
set autowrite
" display incomplete commands
set showcmd
set incsearch
" ignore case unless  there are capital
set ignorecase smartcase
set laststatus=2
" Disable modelines as a security precaution
set modelines=0
set nomodeline
set noeb vb t_vb=
set complete=.,w,b,u,t,i
set completeopt=menu,preview
"  no folding
set nofoldenable
set foldmethod=manual
" insert only one space when joining lines ending with punctuation '.', etc.
set nojoinspaces
set scrolloff=3
set sidescrolloff=3
set relativenumber
set signcolumn=yes
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set list listchars=tab:»·,trail:·,nbsp:·
" Make it obvious where 80 characters is
" set colorcolumn=81
set number
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" Set spellfile to location that is guaranteed to exist, can be symlinked to
set spellfile=$HOME/.vim-spell-en.utf-8.add
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
" Always use vertical diffs
set diffopt+=vertical
set mouse=a


augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | setlocal textwidth=80 | endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
  autocmd! FileType json set sw=2 sts=2 expandtab
  autocmd! FileType scss set sw=2 sts=2 expandtab
  autocmd! FileType elm set sw=4 sts=4 expandtab autoindent smartindent nocindent
  autocmd BufRead,BufNewFile *.sbt set filetype=scala

  " Spell check gitcommits and Markdown
  autocmd FileType gitcommit setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Only wrap md and text
  autocmd BufRead,BufNewFile *.md,*.txt setlocal textwidth=80

  " Remove whitespace at end of lines
  autocmd BufWritePre *.erb,*.scss,*.rb,*.js,*.c,*.py,*.php,*.coffee :%s/\s\+$//e
augroup END

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" use Ag over Grep
set grepprg=ag\ --nogroup\ --nocolor

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=longest,list
set wildmenu
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" statusline
" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" autocmd BufNew,BufEnter *.vim,*.rb,*.erb execute "silent! CocDisable"
" autocmd BufLeave *.vim,*.rb,*.erb execute "silent! CocEnable"
" autocmd BufNew,BufEnter *.scala,*.sbt execute "silent! CocEnable"
" autocmd BufLeave *.scala,*.sbt execute "silent! CocDisable"

set tags=.git/tags,./../.git/tags,./tmp/tags,tags

" convenience
nnoremap <leader>; :
" better copy paste
nmap cp "+y
xnoremap cp "+y
nmap cv "+p
nmap cV "+P

" terminal escape
tnoremap <leader><Esc> <C-\><C-n>

" search
nnoremap <leader>sub :%s///g<left><left>
vnoremap <leader>sub :s///g<left><left>
