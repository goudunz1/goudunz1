" filetype: vim

" auto fold configuration groups
setlocal foldmethod=marker

" shortcuts for loading .vimrc and plugins
nnoremap \S :source <c-r>=expand('%:p')<cr><cr>
nnoremap \I :PlugInstall<cr>
nnoremap \R :PlugClean<cr>
