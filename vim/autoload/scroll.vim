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

