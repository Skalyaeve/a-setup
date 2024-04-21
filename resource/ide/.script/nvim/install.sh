#!/bin/bash
PKGS=(
    "ninja-build"
    "gettext"
    "cmake"
    "unzip"
    "curl"
    "build-essential"
)
for pkg in "${PKGS[@]}";do
    dpkg-query -W -f='${Status}' "$pkg" 2>"/dev/null"\
        | grep -q "install ok installed"\
        && continue
    apt install -y "$pkg" &>"/dev/null" || exit 1
    [[ "$NO_BACKUP" ]] || DIFF+=("apt:$pkg")
done
NAME="neovim"
URL="https://github.com/$NAME/$NAME"
DST="$HOME/.local/src/$NAME"
if [[ -e "$DST" ]];then
    cd "$DST" || exit 1
    make distclean
    git checkout "master" || exit 1
    [[ "$(git pull)" == "Déjà à jour."\
        || "$(git pull)" == "Already up to date." ]]\
        && exit 0
    [[ "$?" -ne 0 ]] && exit 1
else
    git clone "$URL" "$DST" && cd "$DST" || exit 1
fi
git checkout "stable" || exit 1
make CMAKE_BUILD_TYPE="RelWithDebInfo"\
    CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"\
    || exit 1
make install
make clean

CONFIG="$HOME/.config/nvim"
[[ ! -e "$CONFIG" ]] && ! mkdir "$CONFIG" && exit 1

URL="https://raw.githubusercontent.com/Skalyaeve/a-neovim-theme"
SRC="$HOME/.local/src/a-neovim-theme"
[[ ! -e "$SRC" ]] && ! git clone "$URL" "$SRC" && exit 1

[[ -e "$CONFIG/colors" ]] || ln -s "$SRC/colors" "$CONFIG/colors"