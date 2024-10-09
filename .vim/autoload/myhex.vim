" ==============================================================================
" This script provides binary editing features based on xxd
" Example:
" ==============================================================================

" add xxd arguments here
let s:xxdcmd = ":%!xxd"

" reverse hex dump
let s:xxdrcmd = ":%!xxd -r"

let b:MyHexEnabled=0

function! myhex#toggle() abort
    if b:MyHexEnabled
        call myhex#disable()
    else
        call myhex#enable()
    endif
endfunction

function! myhex#enable() abort
	if !executable('xxd')
        echoerr "xxd not found in your $PATH"
        return
    endif

    let b:MyHexEnabled=1
    setlocal bin
    setlocal filetype=
    silent! exec s:xxdcmd
    redraw!

	augroup MyHex
		autocmd!
        autocmd BufReadPost <buffer> setlocal filetype= | silent! exec s:xxdcmd | redraw!
		autocmd BufWritePre <buffer> let s:savedpos = getcurpos() | silent! exec s:xxdrcmd
		autocmd BufWritePost <buffer> silent! exec s:xxdcmd | call cursor([s:savedpos[1], s:savedpos[2]])
		autocmd BufDelete <buffer> setlocal nobin | autocmd! MyHex
	augroup END
endfunction

function! myhex#disable() abort
    let b:MyHexEnabled=0
    setlocal nobin
    silent! autocmd! MyHex
    exec ":e"
endfunction

command! -bang -nargs=0 MyHexToggle call <sid>myhex#toggle()
command! -bang -nargs=0 MyHexEnable call <sid>myhex#enable()
command! -bang -nargs=0 MyHexDisable call <sid>myhex#disable()
