# get lastest version
latestver() {
    if [ $# -eq 1 ] && [ -d $1 ]; then
        ver=$(ls $1 | sort | head -n 1)
        echo -n $1/$ver
    else
        echo -n 'latest'
    fi
}
