" quickly create new files with relative paths
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>ee :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>se :sp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>ve :vsp <C-R>=expand("%:p:h") . "/" <CR>

" Better navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
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

