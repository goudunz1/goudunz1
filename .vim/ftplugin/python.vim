" Python

" execute text as python
function! s:exec_as_python(str)
    let temp=tempname()
    let content=["#!/usr/bin/env python"]+split(a:str,'\n')
    call writefile(content, temp)
    call setfperm(temp,"rwxrwxrwx")
    exe ":!".temp
endfunction

" quick execute
nnoremap <silent><buffer> <leader><cr> :!/usr/bin/env python <c-r>=expand("%")<cr><cr>
nnoremap <silent><buffer> <leader>x 0v$"+y:call <sid>exec_as_python(getreg('+'))<cr>
xnoremap <silent><buffer> <leader>x "+y:call <sid>exec_as_python(getreg('+'))<cr>

let b:commentstring='# %s'
