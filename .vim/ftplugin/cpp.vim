" filetype: c/cpp

" clang-format LLVM style
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" compiler options for testing
let b:compiler=&filetype=="c"?"gcc":"g++"
let &l:makeprg=b:compiler." -O2 -Werror -gdwarf-4 % -o $*"
