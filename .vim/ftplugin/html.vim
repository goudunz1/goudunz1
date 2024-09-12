let b:comment_string = '<!--'

" open in default browser
let b:browser=get(g:,'default_browser','firefox')
nnoremap <silent><buffer> <leader><cr> :w<cr>:call job_start(b:browser.' '.expand('%:p'))<cr>

function! s:init_code()
    call append(line(".")-1,'<!DOCTYPE html>')
    call append(line(".")-1,'<html lang="en">')
    call append(line(".")-1,'<head>')
    call append(line(".")-1,'   <meta charset="UTF-8">')
    call append(line(".")-1,'   <meta name="viewport" content="width=device-width, initial-scale=1.0">')
    call append(line(".")-1,'   <title></title>')
    call append(line(".")-1,'</head>')
    call append(line(".")-1,'<body>')
    call append(line(".")-1,'</body>')
    call append(line(".")-1,'</html>')
endfunction

nnoremap <silent><buffer> <leader>/ :call <sid>init_code()<cr>

