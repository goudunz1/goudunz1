" filetype: python

" execute text as python {{{

function! s:exec_as_python(str)
    let temp=tempname()
    let content=["#!/usr/bin/env python"]+split(a:str,'\n')
    call writefile(content, temp)
    call setfperm(temp,"rwxrwxrwx")
    exe ":!".temp
endfunction

" current line
nnoremap <silent><buffer> \x 0v$"+y:call <sid>exec_as_python(getreg('+'))<cr>

" selected area
xnoremap <silent><buffer> \x "+y:call <sid>exec_as_python(getreg('+'))<cr>

" }}}

" execute current file
nnoremap <silent><buffer> \<cr> :!/usr/bin/env python <c-r>=expand("%")<cr><cr>
