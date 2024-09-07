# File: bashrc
# Author: Yu Sheng(goudunz1)
# Email: goudunz1@outlook.com
# Description: basic bash functions and aliases

# misc
alias q='exit'
alias c='clear'
alias cs='clear;ls'
alias h='history'
alias p='cat'
alias l='less'
alias dt='date'
alias k='kill'
alias j='jobs'
alias rm='rm -vir'
alias ll='ls -A --color=auto'
alias lh='ls -Ad --color=auto .*'
alias lll='ls -alhF --color=auto'
alias pd='pwd'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
alias root='cd /'
alias back='cd $OLDPWD'
alias du*='du -shx *'
alias du.='du -shx .'
alias rbt='sudo reboot'
alias shut='sudo shutdown -h now'
alias m='make'
alias g='git'
alias d='docker'

# apt
alias apth='cat /var/log/dpkg.log | grep'
alias apti='sudo apt install'
alias aptrm='sudo apt purge'
alias aptcs='sudo apt autoremove --purge'
alias aptu='sudo apt update'
alias aptg='sudo apt upgrade'
alias aptl='sudo apt list --installed'

# systemctl
alias srv='sudo systemctl'
alias srvup='sudo systemctl start'
alias srvdown='sudo systemctl stop'
alias srvre='sudo systemctl restart'
alias srven='sudo systemctl enable'
alias srvdis='sudo systemctl disable'

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