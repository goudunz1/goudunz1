" ==============================================================================
" File: vimrc
" Author: goudunz1
" Email: goudunz1@outlook.com
" Note: This is a self-contained vimrc edition with no plugins.
" ==============================================================================

" ==============================================================================
" [vim options] {{{

let mapleader=","               " use ',' as leader key
set nocompatible                " disable legacy mode(vi)
filetype plugin indent on       " enable plugin and indent based on file types
syntax on                       " enable built-in highlight
set t_Co=256                    " require terminal to use 256 colors
set noerrorbells                " turn off error bells
set visualbell t_vb=            " turn off visual beeping
set cmdheight=1                 " height of the cmd line
set showcmd                     " show input in the cmd line
set textwidth=0                 " disable auto <cr>
set ruler                       " show cursor position in status line
set laststatus=2                " show status line
set number                      " show line numbers
set relativenumber              " show relative line numbers
set whichwrap+=<,>,h,l          " cursor key can cross rows
set matchpairs+=<:>             " % can now detect <>
set backspace=indent,eol,start  " delete special characters freely
set virtualedit=block           " virtual select inside a tab
set showtabline=2               " show tab menu
set splitbelow                  " split new window below
set splitright                  " split new vertical window right
set mouse=a                     " enable mouse
set clipboard=unnamed           " host clipboard (require gvim)
set wildmenu                    " better command auto completion
set colorcolumn=80              " 80 characters warning line

set autoindent                  " auto indent according to the previous line
set cindent                     " turn on indent for c-like languages
set cinoptions=g0,:0,N-s,E-s,(0 " see :help cinoptions
set smartindent                 " smartly choose indent way
set expandtab                   " soft tabs instead of tabs
set shiftwidth=4                " use 4 spaces for auto shift
set tabstop=4                   " set width of tab to 4
set softtabstop=4               " use 4 spaces for a soft tab
set smarttab                    " smartly shift with tabs and spaces

set nowrap                      " disable line wrap if cursor too right
set sidescroll=1                " set number of columns to move if cursor too right
set sidescrolloff=4             " keep 4 visible column on the right
set scrolloff=4                 " keep 4 visible line at the bottom

set hlsearch                    " highlight the pattern
set incsearch                   " highlight the pattern when typing
set ignorecase                  " ignore search case
set smartcase                   " smartly ignore search case
set wrapscan                    " searches wrap over EOF

set nobackup                    " disable backup file
set noswapfile                  " disable swap file
set autoread                    " auto load buffer if file changed
set confirm                     " raise a dialog when saving

" }}}
" ==============================================================================
" ==============================================================================
" This script auto pairs parthenses and quotes in vim command line
" ==============================================================================

let g:pair_map={'(':')','[':']','{':'}','"':'"',"'":"'",'<':'>','`':'`',}

" Auto pair function used in cnoremap
" You should use this function in command mode
" ch: Character user inputed
" type: type of the character, should be one of ('pars', 'quotes', 'bs')
function! cmdline#auto_pair(ch, type)
    if a:type==#"pars"
        return s:for_pars(a:ch)
    elseif a:type==#"quotes"
        return s:for_quotes(a:ch)
    elseif a:type==#"bs"
        return s:for_bs()
    endif
endfunction

" Auto pair function for parentheses
" 'parentheses' are those with different opening and closing glyphs
function s:for_pars(ch)
    if has_key(g:pair_map, a:ch)
        return a:ch.g:pair_map[a:ch]."\<left>"
    else
        let pair=getcmdline()[getcmdpos()-1]
        if pair==a:ch
            return "\<right>"
        endif
    endif
    return a:ch
endfunction

" Auto pair function for quotes
" 'quotes' are those with the same opening and closing glyphs
function s:for_quotes(ch)
    let pair=getcmdline()[getcmdpos()-1]
    if pair!=a:ch
        return a:ch.a:ch."\<left>"
    else
        return "\<right>"
    endif
    return a:ch
endfunction

" Auto pair function for backspace
" 'bs' to DELETE
function s:for_bs()
    let pair=getcmdline()[getcmdpos()-1]
    let pair_l=getcmdline()[getcmdpos()-2]
    if has_key(g:pair_map, pair_l)&&(g:pair_map[pair_l]==pair)
        return "\<right>\<bs>\<bs>"
    endif
    return "\<bs>"
endfunction

" ==============================================================================
" This script provides binary editing features
" Example: command! -nargs=0 Hexedit :call hexedit#begin()
"          command! -nargs=0 NoHexedit :call hexedit#stop()
" ==============================================================================

" add xxd arguments here
let s:xxdcmd = ":%!xxd"
" reverse hex dump
let s:xxdrcmd = ":%!xxd -r"

function hexedit#begin() abort
	if !executable('xxd')
        echoerr "xxd not found in your $PATH"
        return
    endif

    setlocal bin
    setlocal filetype=
    silent! exec s:xxdcmd
    redraw!

	augroup HexEdit
		autocmd!
        autocmd BufReadPost <buffer> setlocal filetype= | silent! exec s:xxdcmd | redraw!
		autocmd BufWritePre <buffer> let s:savedpos = getcurpos() | silent! exec s:xxdrcmd
		autocmd BufWritePost <buffer> silent! exec s:xxdcmd | call cursor([s:savedpos[1], s:savedpos[2]])
		autocmd BufDelete <buffer> setlocal nobin | autocmd! HexEdit
	augroup END
endfunction

function hexedit#stop() abort
    setlocal nobin
    silent! autocmd! HexEdit
    exec ":e"
endfunction
" ==============================================================================
" This script change vim's default scrolling behavior
" Credit to Terry Ma:
" https://github.com/terryma/vim-smooth-scroll
" ==============================================================================

" Scroll the screen up
function! scroll#up(dist, duration, speed)
    call s:do_scroll('u', a:dist, a:duration, a:speed)
endfunction

" Scroll the screen down
function! scroll#down(dist, duration, speed)
    call s:do_scroll('d', a:dist, a:duration, a:speed)
endfunction

" Scroll the scroll smoothly
" dir: Direction of the scroll. 'd' is downwards, 'u' is upwards
" dist: Distance, or the total number of lines to scroll
" duration: How long should each scrolling animation last. Each scrolling
" animation will take at least this long. It could take longer if the scrolling
" itself by Vim takes longer
" speed: Scrolling speed, or the number of lines to scroll during each scrolling
" animation
function! s:do_scroll(dir, dist, duration, speed)
    for i in range(a:dist/a:speed)
        let start = reltime()
        if a:dir ==# 'd'
            if line(".") >= line("$")
                break
            endif
            exec "normal! ".a:speed."\<c-e>".a:speed."j"
        else
            if line(".") <= 1
                break
            endif
            exec "normal! ".a:speed."\<c-y>".a:speed."k"
        endif
        redraw
        let elapsed = s:get_ms_since(start)
        let snooze = float2nr(a:duration-elapsed)
        if snooze > 0
            exec "sleep ".snooze."m"
        endif
    endfor
endfunction

function! s:get_ms_since(time)
    let cost = split(reltimestr(reltime(a:time)), '\.')
    return str2nr(cost[0])*1000 + str2nr(cost[1])/1000.0
endfunction

