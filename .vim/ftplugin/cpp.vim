" C/CPP
let g:fuck=123

" clang-format LLVM style
call SetIndent("space", 2)

" compiler options for testing
let b:compiler=&filetype=="c"?"gcc":"g++"
let &l:makeprg=b:compiler." -O2 -Werror -gdwarf-4 % -o $*"

let b:commentstring="// %s"
