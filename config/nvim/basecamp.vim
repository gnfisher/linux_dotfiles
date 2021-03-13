function CopyToBasecamp() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).' | pandoc -f markdown | textutil -stdin -format html -convert rtf -stdout | pbcopy')
endfunction
com -range=% -nargs=0 CopyToBasecamp :<line1>,<line2>call CopyToBasecamp()
xnoremap <Leader>b <esc>:'<,'>CopyToBasecamp<CR>

" nmap <leader>g :silent !open -a iTerm.app '/usr/local/bin/gitsh' &> /dev/null &<CR><CR>:redraw!<CR>
