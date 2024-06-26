#!/bin/bash
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
GRAY='\033[0;37m'
NC='\033[0m'

USAGE="$GRAY===================USAGE
$YELLOW$(basename "$0") $BLUE<video>$NC
"
if [[ "$#" -lt 1 ]];then
    echo -e "$USAGE"
    exit 1
fi
ffmpeg -i "$1" -filter_complex\
    "[0]split[a][b]; [a]palettegen[palette]; [b][palette]paletteuse"\
    "${1%.*}.gif"
