#!/bin/bash
dst="$HOME/.local/src/peda"
if [[ ! -e "$dst" ]];then
    echo -e\
        "\r[$YELLOW WRN $NC] $dst not found,$BLUE installing$NC..."
    bash "install.sh" || exit 1
    exit 0
fi
cd "$dst" || exit 1
echo -ne "\r${BLUE}updating$NC $pkg..."

ret="$(git pull)"
if [[ "$?" -ne 0 ]];then exit 1;fi
if grep -q "Already up to date" <<< "$ret"\
    || grep -q "Déjà à jour" <<< "$ret"
then
    echo -ne "\r$pkg "
fi
