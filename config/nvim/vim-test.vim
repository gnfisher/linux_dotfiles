nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>ta :TestSuite<CR>
nnoremap <silent> <Leader>tv :TestVisit<CR>
let test#strategy = "dispatch"
let test#scala#runner = 'blooptest'
let g:test#scala#blooptest#executable = 'heroku local:run -- bloop'

