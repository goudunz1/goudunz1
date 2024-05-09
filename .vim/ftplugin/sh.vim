" filetype: sh

" execute text as shell script {{{

function! s:exec_as_sh(str)
    let temp=tempname()
    let content=["#!/bin/sh"]+split(a:str,'\n')
    call writefile(content, temp)
    call setfperm(temp,"rwxrwxrwx")
    exec ":!".temp
endfunction

" do exec for selected area
xnoremap <silent><buffer> \x "+y:call <sid>exec_as_sh(getreg('+'))<cr>

" }}}

" execute current file
nnoremap <silent><buffer> \<cr> :!<c-r>=expand("%")<cr><cr>

" execute current line as a command
nnoremap <silent><buffer> \x 0v$"+y:!<c-r>=@+<cr><cr>

" source shell script
nnoremap <silent><buffer> <leader>S :!source <c-r>=expand('%:p')<cr><cr>
