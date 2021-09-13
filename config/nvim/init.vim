let s:editor_root=expand("~/.config/nvim")

set noerrorbells
set mouse=a
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set exrc "use custom vimrc in pwd
set relativenumber
set number
set incsearch
set hidden
set nowrap
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set autoread
set scrolloff=8
set noshowmode
set completeopt=menuone,noselect
set signcolumn=yes
set colorcolumn=80
set cmdheight=2
set updatetime=10
set shortmess+=c
set shortmess-=F
set history=10000
set list listchars=tab:»·,trail:·,nbsp:·
set splitright
set diffopt+=vertical
set cursorline
set fillchars+=vert:\|
set tags^=.git/tags

call plug#begin('~/.vim/bundle')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'scalameta/nvim-metals'
Plug 'mfussenegger/nvim-lint'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-eunuch'
Plug 'vim-test/vim-test'
Plug 'jonathanfilip/vim-lucius'
Plug 'mattn/emmet-vim'
Plug 'derekwyatt/vim-scala'
call plug#end()

runtime macros/matchit.vim

set background=light
colorscheme mac_classic
" colorscheme lucius
" LuciusBlack

" highlight LineNr ctermbg=NONE
" highlight SignColumn ctermbg=NONE

let mapleader=" "
let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'
let test#enabled_runners = ["ruby#rspec"]

fun! TrimWhitespace()
  let l:save = winsaveview()
 keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

fun! JumpToLastLine()
  if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal g`\"" |
  endif
endfun

fun! InsertTabWrapper()
    let col = col('.') - 1
    if !col
        return "\<tab>"
    endif

    let char = getline('.')[col - 1]
    if char =~ '\k'
        " There's an identifier before the cursor, so complete the identifier.
        return "\<c-p>"
    else
        return "\<tab>"
    endif
endfunction

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    prompt_prefix = " > ",
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    color_devicons = true,
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
        },
      },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
        }
      }
  }
}
require('telescope').load_extension('fzy_native')

require'lspconfig'.elmls.setup{}
require'lspconfig'.tailwindcss.setup{}

require('lint').linters_by_ft = {
  ruby = {'standardrb','ruby',}
}

metals_config = require("metals").bare_config
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
  showImplicitArguments = true
  }
EOF

augroup vimrcEx
  autocmd!
  " autocmd BufEnter * lua require'completion'.on_attach()
  autocmd BufWritePre * :call TrimWhitespace()
  autocmd BufReadPost * :call JumpToLastLine()
  autocmd BufWritePost *.rb lua require('lint').try_lint()
  autocmd FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)

  autocmd FileType ruby let b:dispatch = 'ruby %'
  autocmd FileType scala let b:dispatch = 'heroku local:run -- bloop test ads-quoting-server -o "*%:t:r*"'

  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

nnoremap <leader>; :

" better copy paste
nmap cp "+y
xnoremap cp "+y
nmap cv "+p
nmap cV "+P

" use tab to autocomplete
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" quickly create new files with relative paths
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>ee :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>se :sp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>ve :vsp <C-R>=expand("%:p:h") . "/" <CR>

" Better navigation
" noremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" move between wrapped lines
nnoremap j gj
nnoremap k gk

" treat C-c as Esc in insert mode
inoremap <c-c> <esc>
" use C-Space to Esc any mode
nnoremap <C-Space> <Esc>:noh<CR>
vnoremap <C-Space> <Esc>gV
onoremap <C-Space> <Esc>
cnoremap <C-Space> <C-c>
inoremap <C-Space> <Esc>
" terminal sees <C-@> as <C-space>
nnoremap <C-@> <Esc>:noh<CR>
vnoremap <C-@> <Esc>gV
onoremap <C-@> <Esc>
cnoremap <C-@> <C-c>
inoremap <C-@> <Esc>

nnoremap <leader>vr :so ~/dotfiles/config/nvim/init.vim<CR>
nnoremap <leader>q :copen<CR>
nnoremap <leader>x :cclose<CR>

" lsp config
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
nnoremap <leader>fd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>fi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>fsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>fss :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>frr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>frn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>fh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>fca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>fl :lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>fsd :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>fn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>ff :lua vim.lsp.buf.formatting()<CR>

" telescope
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>pk <cmd>lua require('telescope.builtin').grep_string()<CR>
nnoremap <leader>ps <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>pb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>ph <cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>pf <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>pt <cmd>lua require('telescope.builtin').tags()<CR>
" nnoremap <C-j> :cnext<CR>zz
" nnoremap <C-k> :cprev<CR>zz
nnoremap <leader>j :cnext<CR>zz
nnoremap <leader>k :cprev<CR>zz

" compe
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR>    compe#confirm("\<CR>")

" fugitive
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>gb :Gblame<CR>
nmap <leader>gf :diffget //3<CR>
nmap <leader>gj :diffget //2<CR>
nmap <leader>gs :G<CR>

" Run the file you're in with Dispatch
nnoremap <leader>d :Dispatch<CR>

" vim-test
let test#strategy = "dispatch"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
