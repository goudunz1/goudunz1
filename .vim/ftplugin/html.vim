" filetype: html

" open in default browser
let b:browser=get(g:,'default_browser','firefox')
nnoremap <silent><buffer> \<cr> :w<cr>:call job_start(b:browser.' '.expand('%:p'))<cr>

if exists("b:AutoPairs")
    let b:AutoPairs=AutoPairsDefine({'<': '>', '<!--': '-->'})
endif
