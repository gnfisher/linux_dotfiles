let s:editor_root=expand("~/.config/nvim")

call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'janko-m/vim-test'
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-ruby/vim-ruby'
Plug 'ElmCast/elm-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'derekwyatt/vim-scala'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim'
Plug 'fatih/vim-go'
call plug#end()

set encoding=utf-8
autocmd! 
filetype plugin indent on

source $HOME/.config/nvim/appearance.vim
source $HOME/.config/nvim/base.vim
source $HOME/.config/nvim/basecamp.vim
source $HOME/.config/nvim/fzf.vim
source $HOME/.config/nvim/navigation.vim
source $HOME/.config/nvim/vim-test.vim
source $HOME/.config/nvim/airline.vim
source $HOME/.config/nvim/goyo.vim

