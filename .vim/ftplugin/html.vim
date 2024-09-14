" HTML

" open in default browser
let b:browser=get(g:,'default_browser','firefox')
nnoremap <silent><buffer> <leader><cr> :w<cr>:call job_start(b:browser.' '.expand('%:p'))<cr>
