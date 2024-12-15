" filetype: vim

" shortcuts for loading .vimrc
nnoremap <silent><buffer> <leader>S :source <c-r>=expand('%:p')<cr><cr>

" shortcuts for vim-plug
nnoremap <silent><buffer> \I :PlugInstall<cr>
nnoremap <silent><buffer> \R :PlugClean<cr>
