#!/bin/bash

################################################################################
# File: .bashrc
# Inspired by zachbrowne's bashrc
# https://gist.github.com/zachbrowne
################################################################################

################################################################################
# SYSTEM CONFIGURATION
################################################################################

## Source global definitions
#if [ -f /etc/bashrc ]; then
#     . /etc/bashrc
#fi

## Enable bash programmable completion features in interactive shells
#if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

################################################################################
# OPTIONS
################################################################################

# Are we in interactive mode?
imode=$(expr index "$-" i)

# See `man readline` for more readline variables
if [[ $imode > 0 ]]; then
    # Ignore case on auto-completion
    bind "set completion-ignore-case on";

    # Show auto-completion list automatically, without double tab
    bind "set show-all-if-ambiguous on";

    # Disable the bell
    bind "set bell-style visible";
fi

# Set the default editor
export EDITOR=vim
export VISUAL=vim

# Don't put duplicate lines in the history and do not add lines that start with
# a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a
# new terminal, you have old session history
shopt -s histappend

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

################################################################################
# SHORTCUTS
################################################################################

# To temporarily bypass an alias, we preceed the command with a \
# eg: \ls

# Alias to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -irv'
alias mkdir='mkdir -p'
alias md='mkdir -p'
alias ps='ps auxf | less -R' # forest style processes
alias c='clear'
alias cs='clear;ls'
alias cls='clear'
alias q='exit'
alias quit='exit'
alias h='history | less'
alias hist='history | less'
alias p='cat'
alias l='less -R'
alias f='find . | grep'
alias k='kill'
alias j='jobs'
alias dt='date "+%Y-%m-%d %A %T %Z"'
alias e='$EDITOR'
alias se='sudo $EDITOR'
alias t='tree -CAhF --dirsfirst' # file tree with size & color
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias m='make'
alias g='git'
alias d='docker'
alias multitail='multitail --no-repeat -c'

# Alias for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lfile="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# Alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'
alias ,,='cd $OLDPWD'
alias web='cd /var/www/html' # Change the directory to web root

# Show file systems and usage
alias df='df -hT'

# Alias to show disk space and space used in a folder
alias space='du -sh .'
alias fspace='du -h --max-depth=1'
alias fsort="du -S | sort -n -r | more"

# Alias for apt/apt-get
alias apt='sudo apt'
alias apt-get='sudo apt-get'
alias apth='cat /var/log/dpkg.log | less -R'
alias aptl='sudo apt list --installed | less -R'
alias apti='sudo apt-get install'
alias aptu='sudo apt-get update'
alias aptg='sudo apt-get upgrade'
alias aptx='sudo apt-get purge'
alias aptc='sudo apt-get autoremove --purge'

# Alias for systemctl
alias systemctl='sudo systemctl'
alias sup='sudo systemctl start'
alias sdwn='sudo systemctl stop'
alias srst='sudo systemctl restart'
alias sen='sudo systemctl enable'
alias sdis='sudo systemctl disable'
alias schk='sudo systemctl status'

# Alias for tarballs
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Alias for crypto
alias sha1='openssl sha1'
alias sha256='openssl sha256'
alias sha512='openssl sha512'
alias md5='md5sum'
alias b64='base64'

# Count all files (recursively) in the current folder
alias countf="for t in files links directories; \
    do echo \`find . -type \${t:0:1} \
    | wc -l\` \$t; \
    done 2> /dev/null"

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; \
    | grep 'text' \
    | cut -d' ' -f1 \
    | sed -e's/:$//g' \
    | grep -v '[0-9]$' \
    | xargs tail -f"

# Show open ports
alias ports='netstat -nape --inet'

# Show current network connections to the server
alias conns="netstat -anpl \
    | grep ':80' \
    | awk {'print \$5'} \
    | cut -d\":\" -f1 \
    | sort \
    | uniq -c \
    | sort -n \
    | sed -e 's/^ *//' -e 's/ *\$//'"

# List programs sorted by CPU usage
alias topcpu="\\ps -eo pcpu,pid,user,args \
    | sort -k 1 -r \
    | head -10"

# Returns the last 2 fields of the working directory
alias pwdd="pwd \
    | awk -F/ '{nlast=NF-1; print $nlast\"/\"$NF}'"

################################################################################
# FUNCTIONS
################################################################################

# Lazy calculator
calc()
{
    echo $(($@))
}

# Lazy archive extraction
extract ()
{
    for archive in $*; do
        if [ -f $archive ] ; then
            case $archive in
                *.tar.bz2)   tar xvjf $archive    ;;
                *.tar.gz)    tar xvzf $archive    ;;
                *.bz2)       bunzip2 $archive     ;;
                *.rar)       rar x $archive       ;;
                *.gz)        gunzip $archive      ;;
                *.tar)       tar xvf $archive     ;;
                *.tbz2)      tar xvjf $archive    ;;
                *.tgz)       tar xvzf $archive    ;;
                *.zip)       unzip $archive       ;;
                *.Z)         uncompress $archive  ;;
                *.7z)        7z x $archive        ;;
                *)           echo "don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Searches for text in all files in the current folder
ftext ()
{
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines
    # eg. grep -irl "$1" *
    grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp()
{
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
    | awk '{
    count += $NF
    if (count % 10 == 0) {
        percent = count / total_size * 100
        printf "%3d%% [", percent
        for (i=0;i<=percent;i++)
            printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
                printf "]\r"
            }
        }
    END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Show CPU usage (percentage)
cpu ()
{
    top -bn1 | awk '/Cpu/{ printf("%.2f\n",($2+$4)*100/($2+$4+$8)) }'
}

# Copy and go to the directory
cpgo ()
{
    if [ -d "$2" ];then
        cp $1 $2 && cd $2
    else
        cp $1 $2
    fi
}

# Move and go to the directory
mvgo ()
{
    if [ -d "$2" ];then
        mv $1 $2 && cd $2
    else
        mv $1 $2
    fi
}

# Create and go to the directory
mdgo ()
{
    mkdir -p $1
    cd $1
}

# Goes up a specified number of directories  (i.e. up 4)
up ()
{
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
        do
            d=$d/..
        done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# (Un)set HTTP proxy to localhost:<port>
proxy() {
    if [ $# -eq 1 ]; then
        echo "proxy set to port $1"
        export {HTTP,HTTPS,FTP}_PROXY="127.0.0.1:$1"
    elif [ $# -eq 0 ]; then
        echo "unset proxy"
        export {HTTP,HTTPS,FTP}_PROXY=""
    else
        echo "usage: proxy <port>"
    fi
}

# Show the current distribution
distribution ()
{
    local dtype
    # Assume unknown
    dtype="unknown"

    # First test against Fedora / RHEL / CentOS / generic Redhat derivative
    if [ -r /etc/rc.d/init.d/functions ]; then
        source /etc/rc.d/init.d/functions
        [ zz`type -t passed 2>/dev/null` == "zzfunction" ] && dtype="redhat"

    # Then test against SUSE (must be after Redhat,
    # I've seen rc.status on Ubuntu I think? TODO: Recheck that)
    elif [ -r /etc/rc.status ]; then
        source /etc/rc.status
        [ zz`type -t rc_reset 2>/dev/null` == "zzfunction" ] && dtype="suse"

    # Then test against Debian, Ubuntu and friends
    elif [ -r /lib/lsb/init-functions ]; then
        source /lib/lsb/init-functions
        [ zz`type -t log_begin_msg 2>/dev/null` == "zzfunction" ] && \
            dtype="debian"

    # Then test against Gentoo
    elif [ -r /etc/init.d/functions.sh ]; then
        source /etc/init.d/functions.sh
        [ zz`type -t ebegin 2>/dev/null` == "zzfunction" ] && dtype="gentoo"

    # For Mandriva we currently just test if /etc/mandriva-release exists
    # and isn't empty (TODO: Find a better way :)
    elif [ -s /etc/mandriva-release ]; then
        dtype="mandriva"

    # For Slackware we currently just test if /etc/slackware-version exists
    elif [ -s /etc/slackware-version ]; then
        dtype="slackware"

    fi
    echo $dtype
}

# Show the current version of the operating system
ver ()
{
    local dtype
    dtype=$(distribution)

    if [ $dtype == "redhat" ]; then
        if [ -s /etc/redhat-release ]; then
            cat /etc/redhat-release && uname -a
        else
            cat /etc/issue && uname -a
        fi
    elif [ $dtype == "suse" ]; then
        cat /etc/SuSE-release
    elif [ $dtype == "debian" ]; then
        lsb_release -a
    elif [ $dtype == "gentoo" ]; then
        cat /etc/gentoo-release
    elif [ $dtype == "mandriva" ]; then
        cat /etc/mandriva-release
    elif [ $dtype == "slackware" ]; then
        cat /etc/slackware-version
    else
        if [ -s /etc/issue ]; then
            cat /etc/issue
        else
            echo "Error: Unknown distribution"
            exit 1
        fi
    fi
}

# Show current network information
netinfo ()
{
    echo "--------------- Network Information ---------------"
    ifconfig | awk '/inet/{print $2}'
    echo "---------------------------------------------------"
}

# IP address lookup
alias whatismyip="whatsmyip"
whatsmyip ()
{
    # Internal IP Lookup
    echo -n "Internal IP: "
    ifconfig eth0 | grep "inet " | awk '/inet /{print $2}'
    ifconfig wlan0 | grep "inet " | awk '/inet /{print $2}'

    # External IP Lookup
    echo -n "External IP: "
    wget https://myexternalip.com/raw -O - -q
    echo ""
}

# View Apache logs
apachelog ()
{
    # test multitail
    command -v multitail >/dev/null && \
        local cmd='multitail --no-repeat -c -s 2' || \
        cmd='tail'

    if [ -f /etc/httpd/conf/httpd.conf ]; then
        cd /var/log/httpd && \
            ls -xAh && \
            $cmd /var/log/httpd/*_log
    else
        cd /var/log/apache2 && \
            ls -xAh && \
            $cmd /var/log/apache2/*.log
    fi
}

# Edit the Apache configuration
apachecfg () {
    if [ -f /etc/httpd/conf/httpd.conf ]; then
        se /etc/httpd/conf/httpd.conf
    elif [ -f /etc/apache2/apache2.conf ]; then
        se /etc/apache2/apache2.conf
    else
        echo "Error: Apache config file could not be found."
    fi
}

# Edit the PHP configuration file
phpcfg () {
    if [ -f /etc/php.ini ]; then
        se /etc/php.ini
    elif [ -f /etc/php/php.ini ]; then
        se /etc/php/php.ini
    elif [ -f /etc/php5/php.ini ]; then
        se /etc/php5/php.ini
    elif [ -f /usr/bin/php5/bin/php.ini ]; then
        se /usr/bin/php5/bin/php.ini
    elif [ -f /etc/php5/apache2/php.ini ]; then
        se /etc/php5/apache2/php.ini
    else
        echo "Error: php.ini file could not be found."
    fi
}

# Edit the MySQL configuration file
mysqlcfg ()
{
    if [ -f /etc/my.cnf ]; then
        se /etc/my.cnf
    elif [ -f /etc/mysql/my.cnf ]; then
        se /etc/mysql/my.cnf
    elif [ -f /usr/local/etc/my.cnf ]; then
        se /usr/local/etc/my.cnf
    elif [ -f /usr/bin/mysql/my.cnf ]; then
        se /usr/bin/mysql/my.cnf
    elif [ -f ~/my.cnf ]; then
        se ~/my.cnf
    elif [ -f ~/.my.cnf ]; then
        se ~/.my.cnf
    else
        echo "Error: my.cnf file could not be found."
    fi
}

# For some reason, rot13 pops up everywhere
rot13 ()
{
    if [ $# -eq 0 ]; then
        tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    else
        echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    fi
}

# Trim leading and trailing spaces (for scripts)
trim ()
{
    local var=$@
    var="${var#"${var%%[![:space:]]*}"}"  # for leading
    var="${var%"${var##*[![:space:]]}"}"  # for trailing
    echo -n "$var"
}

################################################################################
# PROMPT STRING
################################################################################

# Define colors
LIGHTGRAY="\033[1;37m"
WHITE="\033[1;37m"
BLACK="\033[1;30m"
DARKGRAY="\033[1;30m"
RED="\033[1;31m"
LIGHTRED="\033[1;31m"
GREEN="\033[1;32m"
LIGHTGREEN="\033[1;32m"
BROWN="\033[1;33m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
LIGHTBLUE="\033[1;34m"
MAGENTA="\033[1;35m"
LIGHTMAGENTA="\033[1;35m"
CYAN="\033[1;36m"
LIGHTCYAN="\033[1;36m"
NOCOLOR="\033[0m"

if [[ $EUID -ne 0 ]]; then
    PROMPT="\[${NOCOLOR}\][\[${LIGHTBLUE}\]"
else
    PROMPT="\[${NOCOLOR}\][\[${LIGHTRED}\]"
fi

# User and server
ssh_ip=`echo $SSH_CLIENT | awk '{ print $1 }'`
ssh2_ip=`echo $SSH2_CLIENT | awk '{ print $1 }'`
if [ $ssh2_ip ] || [ $ssh_ip ] ; then
    PROMPT+="\u@\h\[${NOCOLOR}\]㉿"
else
    PROMPT+="\u\[${NOCOLOR}\]㉿"
fi
unset ssh_ip
unset ssh2_ip

# Current directory
PROMPT+="\[${NOCOLOR}\]\[${LIGHTGREEN}\]\W\[${NOCOLOR}\]]"

if [[ $EUID -ne 0 ]]; then
    PROMPT+="\$\[${NOCOLOR}\] " # Normal user
else
    PROMPT+="#\[${NOCOLOR}\] " # Root user
fi

__setprompt ()
{
    # Show error exit code if there is one
    local CODE=$? # should be the first command

    # Date
    PS1="\[${NOCOLOR}\][\[${BROWN}\]$(date +%a\ %H:%M)\[${NOCOLOR}\]]"$PROMPT

    if [[ $CODE != 0 ]]; then
        PS1="\[${NOCOLOR}\][\[${LIGHTRED}\]$CODE\[${NOCOLOR}\]]"$PS1
    fi
}

PROMPT_COMMAND='__setprompt'

# PS2 is used to continue a command using the \ character
PS2="\[${NOCOLOR}\]>\[${NOCOLOR}\] "

# PS3 is used to enter a number choice in a script
PS3='Please enter a number from above list: '

# PS4 is used for tracing a script in debug mode
PS4="\[${NOCOLOR}\]+\[${NOCOLOR}\] "

