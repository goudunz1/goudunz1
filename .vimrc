" ==============================================================================
" File: vimrc
" Author: goudunz1
" Email: goudunz1@outlook.com
" Note: This is a self-contained vimrc edition with no plugins.
" ==============================================================================

let g:author = "goudunz1"
let g:email = "goudunz1@outlook.com"
let g:default_browser = "firefox"
iabbrev <expr> @@n g:author
iabbrev <expr> @@e g:email
colorscheme industry

" ==============================================================================
" [vim options] {{{

let mapleader = ","             " use ',' as leader key
set nocompatible                " disable legacy mode(vi)
filetype plugin indent on       " enable plugin and indent based on file types
syntax on                       " enable built-in highlight
set noerrorbells                " turn off error bells
set novisualbell                " turn off visual beeping
set cmdheight=1                 " height of the cmd line
set showcmd                     " show input in the cmd line
set textwidth=0                 " disable auto <cr>
set ruler                       " show cursor position in status line
set laststatus=2                " show status line
set number                      " show line numbers
set relativenumber              " show relative line numbers
"set whichwrap+=h,l              " cursor key can cross rows
set matchpairs+=<:>             " % can now detect <>
set backspace=indent,eol,start  " delete special characters freely
set virtualedit=block           " virtual select inside a tab
set showtabline=2               " show tab menu
set splitbelow                  " split new window below
set splitright                  " split new vertical window right
set mouse=                      " enable mouse
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
set sidescrolloff=1             " keep 1 visible column on the right
set scrolloff=1                 " keep 1 visible line at the bottom

set hlsearch                    " highlight the pattern
set incsearch                   " highlight the pattern when typing
set ignorecase                  " ignore search case
set smartcase                   " smartly ignore search case
"set wrapscan                    " searches wrap over EOF

set nobackup                    " disable backup file
set noswapfile                  " disable swap file
set autoread                    " auto load buffer if file changed
set confirm                     " raise a dialog when saving

" }}}
" ==============================================================================

" ==============================================================================
" [user scripts] {{{

" marcos {{{

" run marco in visual mode
xnoremap @ :normal! @

" repeat for marco, use the marco once and do <c-q>
nnoremap <c-q> @@

" }}}

" code folding {{{

" toggle line wrap
nnoremap <silent> <leader>z :let &l:wrap=!&l:wrap<cr>
xnoremap <silent> <leader>z :let &l:wrap=!&l:wrap<cr>

" move into line wraps instead of jumping over it
noremap j gj
noremap k gk

" switch between fold methods
nnoremap <silent> <leader>m :let &l:fdm=&l:fdm=="marker"?"indent":"marker"<cr>
xnoremap <silent> <leader>m :let &l:fdm=&l:fdm=="marker"?"indent":"marker"<cr>

" auto fold with <space> and <bs>
nmap <silent><nowait> <expr><space> foldlevel('.')>0?"zo":"\<space>"
nmap <silent><nowait> <expr><bs> foldlevel('.')>0?"zc":"\<bs>"

" }}}

" search and replace {{{

" toggle search pattern highlight
nnoremap <silent> <leader>h :noh<cr>
xnoremap <silent> <leader>h :noh<cr>

" find keywords downwards, example: ve/
xnoremap <silent> / "sy/\V\<<c-r>=@s<cr>\><cr>

" find keywords upwards, example: ve?
xnoremap <silent> ? "sy?\V\<<c-r>=@s<cr>\><cr>

" replace keyword with <f2>, note that register s will be used!
xnoremap <f2> "sy/\V\<<c-r>=@s<cr>\><cr><c-o>:%s/\V\<<c-r>=@s<cr>\>/

" }}}

" selection {{{

" extend matching with '%'
packadd! matchit

" deprecated, use matchit plugin instead
" locate nearest { below
"nnoremap <silent> <leader>{ /{<cr>:noh<cr>va}
"xnoremap <silent> <leader>{ <c-[>/{<cr>:noh<cr>va}

" locate nearest } above
"nnoremap <silent> <leader>} ?}<cr>:noh<cr>va{
"xnoremap <silent> <leader>} <c-[>?}<cr>:noh<cr>va{

" move selected area upward/downward
xnoremap <silent> <c-k> :move '<-2<cr>gv
xnoremap <silent> <c-j> :move '>+1<cr>gv

" move selected area to window on the left/right
xnoremap <c-h> y<c-w>hi<c-[>vpgv
xnoremap <c-l> y<c-w>li<c-[>vpgv

" }}}

" buffer {{{

" reload/redraw buffer
nnoremap <silent> <leader>r :e<cr>
xnoremap <silent> <leader>r :e<cr>
nnoremap <silent> <leader>R :redraw!<cr>
xnoremap <silent> <leader>R :redraw!<cr>

func! s:change_buf(towards) abort
    if &ft == 'netrw'
        echoerr "netrw cannot be changed"
        return
    endif
    if &bt != ''
        echoerr "buftype ". &bt. " cannot be changed"
        return
    endif
    if a:towards == 'n' | bn | else | bp | endif
	while &bt != ''
        if a:towards == 'n' | bn | else | bp | endif
    endwhile
endfunc

" select previous buffer
nnoremap <silent> <leader>j :call<space><sid>change_buf('p')<cr>
xnoremap <silent> <leader>j :call<space><sid>change_buf('p')<cr>

" select next buffer
nnoremap <silent> <leader>k :call<space><sid>change_buf('n')<cr>
xnoremap <silent> <leader>k :call<space><sid>change_buf('n')<cr>

" store recent closes
let g:recent_closed_bufs={}

func! s:get_recent_closed_bufs() abort
	let list = []
	for [key, value] in items(g:recent_closed_bufs)
		let value['filename'] = key
		call insert(list, value)
	endfor
	call sort(list, {m1, m2 -> m1['time'] > m2['time'] ? -1 : 1})
	call setqflist(list, 'r')
	copen
endfunc

func! s:close_buf() abort
    if bufname() == '' || len(getbufinfo({'buflisted': 1})) == 0
        quit | return
    endif
    if &bt == 'quickfix'
        cclose | return
    elseif &bt == 'loclist'
        lclose | return
    endif
    if (&bt != '' || &ft == 'netrw')
        bd | return
    endif
    if &bt == ''
        let buf_now = bufnr()
        " save recent closed buffers
        let g:recent_closed_bufs[bufname()] = {
                    \'lnum': line('.'),
                    \ 'col': col('.'),
                    \'text': 'closed at '.strftime("%H:%M"),
                    \'time': localtime()
                    \}
        " go back to the last buffer before we switched to this one
        let buf_jump_list = getjumplist()[0]
        let buf_jump_now = getjumplist()[1] - 1
        while buf_jump_now >= 0
            let last_nr = buf_jump_list[buf_jump_now]["bufnr"]
            let last_line = buf_jump_list[buf_jump_now]["lnum"]
            if buf_now != last_nr && bufloaded(last_nr) &&
                        \getbufvar(last_nr, "&bt") == ''
                execute ":b ".last_nr
                execute ":bd ".buf_now
                return
            else
                let buf_jump_now -= 1
            endif
        endwhile
        bp | while &bt != '' | bp | endwhile
        execute "bd ".buf_now
    endif
endfunc

" leave current buffer
nnoremap <silent> <leader>q :call<space><sid>close_buf()<cr>
xnoremap <silent> <leader>q :call<space><sid>close_buf()<cr>

" get recent closed buffers
nnoremap <silent> <leader>Q :call <sid>get_recent_closed_bufs()<cr>
xnoremap <silent> <leader>Q :call <sid>get_recent_closed_bufs()<cr>

augroup BufferEvents
    autocmd!
    " remember the last position when re-opening a buffer
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
                \exec "normal! g'\"" | endif

    " set cursor line if and only if window on focus
    autocmd BufEnter,WinEnter * setlocal cursorline
    autocmd BufLeave,WinLeave * setlocal nocursorline
    "autocmd BufEnter,WinEnter * setlocal cursorcolumn
    "autocmd BufLeave,WinLeave * setlocal nocursorcolumn
augroup end

" save current buffer
nnoremap <silent> <leader>w :w<cr>
xnoremap <silent> <leader>w :w<cr>

" load file in new buffer
nnoremap <leader>e :e<space><c-r>=getcwd()<cr>/
xnoremap <leader>e :e<space><c-r>=getcwd()<cr>/
nnoremap <leader>E :e<space>/
xnoremap <leader>E :e<space>/

" }}}

" split view {{{

" adjust window boundary
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w><
noremap <c-right> <c-w>>

" change focused window
noremap <up> <c-w>k
noremap <down> <c-w>j
noremap <left> <c-w>h
noremap <right> <c-w>l

" adjust window position
noremap <leader><up> <c-w>K
noremap <leader><down> <c-w>J
noremap <leader><left> <c-w>H
noremap <leader><right> <c-w>L

" scroll in the other window (for reading or referrence)
nnoremap \<c-u> <c-w>p<c-u><c-w>p
nnoremap \<c-d> <c-w>p<c-d><c-w>p
nnoremap \<c-f> <c-w>p<c-f><c-w>p
nnoremap \<c-b> <c-w>p<c-b><c-w>p
nnoremap \<c-y> <c-w>p<c-y><c-w>p
nnoremap \<c-e> <c-w>p<c-e><c-w>p


" scroll with cursor (in the other window)
nnoremap \zz <c-w>pzz<c-w>p
nnoremap \zt <c-w>pzt<c-w>p
nnoremap \zb <c-w>pzb<c-w>p

" 'man' instead of two words 'vert help'
cnoreab man vert help

" }}}

" scrolling {{{

" eye friendly ctrl-o
nnoremap <c-o> <c-o>zz

" }}}

" multitask {{{

" open a new empty tab
nnoremap <leader><tab> :tabnew<cr>:e <c-r>=getcwd()<cr>/
xnoremap <leader><tab> :tabnew<cr>:e <c-r>=getcwd()<cr>/
nnoremap <leader><bs> :tabclose<cr>
xnoremap <leader><bs> :tabclose<cr>

" open a new empty window
nnoremap <leader>v :vert new<cr>:e <c-r>=getcwd()<cr>/
xnoremap <leader>v :vert new<cr>:e <c-r>=getcwd()<cr>/
nnoremap <leader>V :new<cr>:e <c-r>=getcwd()<cr>/
xnoremap <leader>V :new<cr>:e <c-r>=getcwd()<cr>/

" open up a terminal
nnoremap <silent> <leader>t :vert term<cr>
xnoremap <silent> <leader>t :vert term<cr>
nnoremap <silent> <leader>T :bo term ++rows=6<cr>
xnoremap <silent> <leader>T :bo term ++rows=6<cr>

" open up a terminal in a new tab
nnoremap <silent> <leader>x :tabe<cr>:vert term ++curwin ++close<cr>
xnoremap <silent> <leader>x :tabe<cr>:vert term ++curwin ++close<cr>

" open up a terminal in a new tab under directory of current file
nnoremap <silent> <leader>X :tabe<cr>:call term_start("bash",
            \{"cwd":"<c-r>=expand('%:p:h')<cr>",
            \"curwin":1,"term_finish":"close"})<cr>
xnoremap <silent> <leader>X :tabe<cr>:call term_start("bash",
            \{"cwd":"<c-r>=expand('%:p:h')<cr>",
            \"curwin":1,"term_finish":"close"})<cr>

" run async tasks with 'vert term'
command! -complete=shellcmd -nargs=+ Run exec "vert term ".<q-args>
"cnoreab bang Run
" use AsyncRun instead, the result will be stored in quickfix
cnoreab bang AsyncRun

" TODO: take over vim in terminal

" }}}

" code cleanup {{{

" unhide control characters
nnoremap <silent> <leader>i :let &l:list=!&l:list<cr>
xnoremap <silent> <leader>i :let &l:list=!&l:list<cr>

" highlight all trailing spaces
match DiffDelete /\v\s+$/

" erase trailing spaces, example ggvG\d<space>
nnoremap <silent> d<space> :s/\v\s+$//<cr>:noh<cr><c-o>
xnoremap <silent> <leader>d<space> :s/\v\s+$//<cr>:noh<cr><c-o>

" erase empty lines, example: ggvG\d<cr>
nnoremap <silent> d<cr> :/^\s*$/d<cr>:noh<cr>
xnoremap <silent> <leader>d<cr> :/^\s*$/d<cr>:noh<cr>

" clear the current line
nnoremap dc d0d$

" re-enter the current line
nnoremap di d0d$i

" re-enter the current line (insert mode)
inoremap <c-d> <c-o>cc

" }}}

" yank and paste {{{

" yank a whole line
nnoremap yy Y

" yank from system clipboard
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>Y "+Y
xnoremap <leader>Y "+Y

" paste to system clipboard
nnoremap <leader>p "+p
xnoremap <leader>p "+p
nnoremap <leader>P "+P
xnoremap <leader>P "+P

" }}}

" lazy indent {{{

" quick indent in normal/visual mode
nnoremap <tab> >>
xnoremap <tab> >gv
nnoremap <s-tab> <<
xnoremap <s-tab> <gv

" TODO: convert front tabs to tabwidth spaces and vice versa

" press <leader> then hold <space> to add more spaces, <esc> to stop
nnoremap <silent> <leader><space> i<space><c-[>
            \:while getchar()==32<bar>
            \undoj<bar>
            \exec "normal!i<space>"<bar>
            \redraw<bar>
            \endwhile<cr>

" press <leader> then hold o/O to add empty lines, <esc> to stop
nnoremap <silent> <leader>o :call append(line('.'),"")<cr>
            \:while getchar()==111<bar>
            \undoj<bar>
            \call append(line('.'),"")<bar>
            \redraw<bar>
            \endwhile<cr>
nnoremap <silent> <leader>O :call append(line('.')-1,"")<cr>
            \:while getchar()==79<bar>
            \undoj<bar>
            \call append(line('.')-1,"")<bar>
            \redraw<bar>
            \endwhile<cr>

" insert empty lines in normal mode
nnoremap <silent> <enter> :call append(line('.'),"")<cr>j

" }}}

" lazy cmode {{{

" tcsh-style command line (bash compatible)
cnoremap <c-a> <home>
cnoremap <c-b> <left>
cnoremap <c-f> <right>

" command line key characters, you can modifiy these for better performance
let g:cmd_pairs={'(': ')', '[': ']', '{': '}', '<': '>', '"': '"', "'": "'",
            \ '`': '`'}

" auto complete command line key characters
func! s:cmd_auto_pair(ch) abort
    if has_key(g:cmd_pairs, a:ch)
        return a:ch. g:cmd_pairs[a:ch]. "\<left>"
    elseif a:ch == getcmdline()[getcmdpos() - 1]
        return "\<right>"
    else
        return a:ch
    endif
endfunc

cnoremap <expr> ( <sid>cmd_auto_pair('(')
cnoremap <expr> ) <sid>cmd_auto_pair(')')
cnoremap <expr> [ <sid>cmd_auto_pair('[')
cnoremap <expr> ] <sid>cmd_auto_pair(']')
cnoremap <expr> { <sid>cmd_auto_pair('{')
cnoremap <expr> } <sid>cmd_auto_pair('}')
cnoremap <expr> < <sid>cmd_auto_pair('<')
cnoremap <expr> > <sid>cmd_auto_pair('>')
cnoremap <expr> " <sid>cmd_auto_pair('"')
cnoremap <expr> ' <sid>cmd_auto_pair("'")
cnoremap <expr> ` <sid>cmd_auto_pair('`')

" auto delete verbose key characters
func! s:cmd_auto_bs() abort
    let cr = getcmdline()[getcmdpos() - 1]
    let cl = getcmdline()[getcmdpos() - 2]
    if has_key(g:cmd_pairs, cl) && (g:cmd_pairs[cl] == cr)
        return "\<right>\<bs>\<bs>"
    else
        return "\<bs>"
    endif
endfunc

cnoremap <expr> <bs> <sid>cmd_auto_bs()

" }}}

" lazy IO {{{

" change pwd
cnoreab cd cd <c-r>=expand('%:p:h')<cr>

" remove current file
command! -nargs=0 -bang Remove call delete(expand('%')) | :bd | :bn
cnoreab rm Remove

" rename current file
command! -nargs=1 -bang -complete=file Rename let @s=expand('%') |
            \file <args> | write! | call delete(@s)
cnoreab <expr>mv "Rename ".expand('%:p:h')

" make new directory
command! -nargs=1 -bang -complete=file Mkdir echo mkdir(<f-args>)
cnoreab <expr>md "Mkdir ".expand('%:p:h')

" remove directory
command! -nargs=1 -bang -complete=file Rmdir echo delete(<f-args>, "d")
cnoreab <expr>rd "Rmdir ".expand('%:p:h')

" force write
command! -nargs=0 -bang SudoWrite w !sudo tee % >/dev/null
cnoreab w!! SudoWrite
nnoremap <leader>W :w!!<cr>
xnoremap <leader>W :w!!<cr>

" }}}

" Goto eXternal link {{{
" use netrw's gx if present
if !exists("g:loaded_netrw")
    func! s:gx() abort
    	let m = matchstrpos(getline('.'), 'https*://\S[^][(){}]*')
    	while m[0] != '' && (m[1] > col('.') || m[2] < col('.'))
    		let m = matchstrpos(getline('.'), 'https*://\S[^][(){}]*', m[2])
    	endwhile
        if m[0] != ''
    	    let browser = get(g:, 'default_browser', 'firefox')
            let link = m[0]
            call job_start(browser. ' '. link)
        else
            echoerr 'cannot find link'
        endif
    endfunc

    nnoremap <silent><nowait> gx :call<space><sid>gx()<cr>
endif

" }}}

" quickfix {{{

" get quickfix window number
func! s:getqfwinnr() abort
    let wins = filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')
    return empty(wins) ? 0 : wins[0].winnr
endfunc

" <leader>+c to toggle quickfix window
nnoremap <silent><expr> <leader>c <sid>getqfwinnr() ? ":cclose\<cr>" :
            \":copen\<cr>"

" scroll between quickfix results
nnoremap <silent> <c-p> :cprevious<cr>
xnoremap <silent> <c-p> :cprevious<cr>
nnoremap <silent> <c-n> :cnext<cr>
xnoremap <silent> <c-n> :cnext<cr>

" TODO: <leader>+C to toggle quickfix popup menu
func! s:qfpopup() abort
endfunc

nnoremap <leader>C :call <sid>qfpopup()<cr>
" }}}

" vim diff {{{

" shortcuts to open up a vimdiff window
command! -nargs=1 -bang -complete=file Diff exec ":vert diffsplit ".<q-args>
cnoreab <expr> diff "Diff ".expand('%:p').".bak"

" }}}

" }}}
" ==============================================================================
