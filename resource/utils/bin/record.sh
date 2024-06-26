#!/bin/bash
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
GRAY='\033[0;37m'
NC='\033[0m'

USAGE="$GRAY===================USAGE
$YELLOW$(basename "$0") $BLUE<output> [size] [pos]$NC

$BLUE<output>$NC: exemple.mp4
$BLUE[size]$NC: 1920x1080
$BLUE[pos]$NC: 0,0
"
if [[ "$#" -lt 1 ]];then
    echo -e "$USAGE"
    exit 1
fi
BASE='ffmpeg -f x11grab'
POS='-i :0.0'
[[ "$#" -gt 1 ]] && SIZE="-s $2"
[[ "$#" -gt 2 ]] && POS="-i :0.0+$3"

eval "$BASE $SIZE $POS -y $1"
