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

