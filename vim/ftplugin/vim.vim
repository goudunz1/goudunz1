" Vim Scripts

" auto fold configuration groups
setlocal foldmethod=marker

" shortcuts for loading .vimrc and plugins
nnoremap <leader><leader>s :source <c-r>=expand('%:p')<cr><cr>
nnoremap <leader><leader>i :PlugInstall<cr>
nnoremap <leader><leader>c :PlugClean<cr>
