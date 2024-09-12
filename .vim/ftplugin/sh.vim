" Shell Scripts

" execute text as shell script
function! s:exec_as_sh(str)
    let temp=tempname()
    let content=["#!/bin/sh"]+split(a:str,'\n')
    call writefile(content, temp)
    call setfperm(temp,"rwxrwxrwx")
    exec ":!".temp
endfunction

" quick execute
nnoremap <leader><leader>s :!source <c-r>=expand('%:p')<cr><cr>
nnoremap <silent><buffer> <leader><cr> :!<c-r>=expand("%")<cr><cr>
nnoremap <silent><buffer> <leader>x 0v$"+y:!<c-r>=@+<cr><cr>
xnoremap <silent><buffer> <leader>x "+y:call <sid>exec_as_sh(getreg('+'))<cr>

let b:commentstring='# %s'
