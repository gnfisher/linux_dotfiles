" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" only show the parent folder in tabline if nested deeper.
function! TabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let currentBuffPath = bufname(buflist[winnr - 1])
  return fnamemodify(currentBuffPath, ":h:t") . "/" . fnamemodify(currentBuffPath, ":t")
endfunction

function! TabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= ' %{TabLabel(' . (i + 1) . ')} '
  endfor
  let s .= '%#TabLineFill#%T'
  return s
endfunction

set tabline=%!TabLine()
syntax enable
" set t_Co=256 " 256 colors
" a better pattern for drawing vertical borders.
set fillchars+=vert:\|
set termguicolors
set background=light
" colorscheme solarized8
" colorscheme github
highlight clear SignColumn
let g:is_posix = 1

