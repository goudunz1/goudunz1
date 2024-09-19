setproxy() {
    if [ $# -eq 1 ]; then
        echo "proxy set to port $1"
        export {HTTP,HTTPS,FTP}_PROXY="127.0.0.1:$1"
    else
        echo "usage: setproxy <port>"
    fi
}

unsetproxy() {
    if [ $# -ne 0 ]; then
        echo "unset proxy"
        export {HTTP,HTTPS,FTP}_PROXY=""
    else
        echo "usage: unsetproxy"
    fi
}
