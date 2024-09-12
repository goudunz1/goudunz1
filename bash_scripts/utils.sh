#!/bin/bash

# lazy extract
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar -xvjf $1 ;;
            *.tar.gz) tar -xvzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar -x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar -xvf $1 ;;
            *.tbz2) tar -xvjf $1 ;;
            *.tgz) tar -xvzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z -x $1 ;;
            *) echo "extract: unknow file type" ;;
        esac
    else
        echo "usage: extract FILE"
    fi
}

# set proxy to port $1
allproxy() {
    if [ $# -eq 1 ]; then
        echo "allproxy: proxy set to port $1"
        export HTTP_PROXY="http://127.0.0.1:$1"
        export HTTPS_PROXY="http://127.0.0.1:$1"
        export ALL_PROXY="http://127.0.0.1:$1"
    else
        echo "allproxy: proxy unset"
        export HTTP_PROXY=""
        export HTTPS_PROXY=""
        export ALL_PROXY=""
    fi
}

# get lastest version
latestver() {
    if [ $# -eq 1 ] && [ -d $1 ]; then
        ver=$(ls $1 | sort | head -n 1)
        echo -n $1/$ver
    else
        echo -n 'latest'
    fi
}
