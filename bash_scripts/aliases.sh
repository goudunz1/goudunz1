#!/bin/bash

alias q='exit'
alias h='history'
alias p='cat'
alias l='less'
alias dt='date'
alias k='kill'
alias j='jobs'
alias rm='rm -vir'
alias duu='du -shx .'
alias dul='du -shx *'
alias m='make'
alias g='git'
alias d='docker'

alias ll='ls -A --color=auto'
alias lh='ls -Ad --color=auto .*'
alias lll='ls -alhF --color=auto'

alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
alias ,='cd $OLDPWD'

alias c='clear'
alias cs='c;ls'
alias cls='cs'

if [ $EUID -eq 0 ]; then
    command -v poweroff >/dev/null||alias poweroff='shutdown --poweroff now'
    command -v halt >/dev/null||alias halt='shutdown --halt now'
    command -v reboot >/dev/null||alias reboot='shutdown --reboot now'
    alias pkg='apt-get'
    alias srv='systemctl'
else
    command -v poweroff >/dev/null||alias poweroff='sudo shutdown --poweroff now'
    command -v halt >/dev/null||alias halt='sudo shutdown --halt now'
    command -v reboot >/dev/null||alias reboot='sudo shutdown --reboot now'
    alias pkg='sudo apt'
    alias srv='sudo systemctl'
fi

alias pkgh='cat /var/log/dpkg.log | grep'
alias pkgl='pkg list --installed | grep'
alias pkgi='pkg install'
alias pkgu='pkg update'
alias pkgg='pkg upgrade'
alias pkgx='pkg purge'
alias pkgc='pkg autoremove --purge'

alias srvu='srv start'
alias srvd='srv stop'
alias srvr='srv restart'
alias srvy='srv enable'
alias srvx='srv disable'
alias srvq='srv status'
