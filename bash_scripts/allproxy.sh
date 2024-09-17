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

