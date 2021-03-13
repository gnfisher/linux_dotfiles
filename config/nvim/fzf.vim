let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --hidden -g ""'
let g:fzf_layout = { 'down': '~60%' }
nnoremap <C-p> :Files<CR>
nnoremap <C-a> :Ag<space>
nnoremap <leader>fp :Files<cr>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tag<cr>
nnoremap <leader>fo :BTag<cr>
