let g:airline#extensions#ale#enabled = 1

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['ruby'] = ['standardrb']
let g:ale_fix_on_save = 1
