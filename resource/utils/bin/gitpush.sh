#!/bin/bash
# crontab -e => 0 22 * * * ~/.local/bin/gitpush ~/.local/share/git
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
GRAY="\033[0;37m"
NC="\033[0m"

USAGE="$GRAY===================USAGE$NC
$YELLOW$(basename "$0") $BLUE<path> $GREEN[options]$NC

Navigate from the specified path
Push all changes to the remote repository
Read .add files to add specific files instead of *
Read .msg files to change default commit message
Read .ord files to change push order

$GREEN[options]$NC:
-e, --exclude <dir(s)>
    $RED*$NC Don't push changes from specified directories
-a, -add <items(s)>
    $RED*$NC Change default files/folders to add
-m, --message <string>
    $RED*$NC Change default commit message
--rm-add [dir(s)]
    $RED*$NC Remove .add files from all/specified directories
--rm-msg [dir(s)]
    $RED*$NC Remove .msg files from all/specified directories
-s, --silent
    $RED*$NC Run in silent mode
"
if [[ "$#" -lt 1 ]];then
    echo -e "$USAGE"
    exit 1
fi
ft_echo(){
    [[ "$SILENT" ]] || echo -ne "$@"
    return 0
}
ROOT="$1"
shift
TO_ADD=("*")
MESSAGE="update"

err(){
    ft_echo "[$RED ERR $NC] $1\n"
    exit 1
}
while [[ "$#" -gt 0 ]];do
    case "$1" in
    "-e" | "--exclude")
        [[ "$#" -eq 1 ]] && err "Missing argument for $GREEN$1$NC"
        shift
        while [[ "$#" -gt 0 ]];do
            [[ "${1:0:1}" == "-" ]] && break
            EXCLUDE+=("$1")
            shift
        done
        ;;
    "-a" | "-add")
        [[ "$#" -eq 1 ]] && err "Missing argument for $GREEN$1$NC"
        shift
        while [[ "$#" -gt 0 ]];do
            [[ "${1:0:1}" == "-" ]] && break
            TO_ADD+=("$1")
            shift
        done
        ;;
    "-m" | "--message")
        [[ "$#" -eq 1 ]] && err "Missing argument for $GREEN$1$NC"
        shift
        MESSAGE="$1"
        ;;
    "--rm-add")
        shift
        while [[ "$#" -gt 0 ]];do
            [[ "${1:0:1}" == "-" ]] && break
            RM_ADD+=("$1")
            shift
        done
        [[ "${#RM_ADD[@]}" -eq 0 ]] && RM_ADD=("*")
        ;;
    "--rm-msg")
        shift
        while [[ "$#" -gt 0 ]];do
            [[ "${1:0:1}" == "-" ]] && break
            RM_MSG+=("$1")
            shift
        done
        [[ "${#RM_MSG[@]}" -eq 0 ]] && RM_MSG=("*")
        ;;
    "-s" | "--silent")
        shift
        SILENT=1
        ;;
    *) err "Unknown option $GREEN$1$NC";;
    esac
done
cd "$ROOT" || exit 1

for target in "${EXCLUDE[@]}";do
    excluded="$(find . -type d -name "$target")"
    [[ "$excluded" ]] || err "$target not found"

    repo="$(find "$excluded" -type d -name ".git")"
    [[ "$repo" ]] || err "$target is not a git repository"
done

do_it(){
    local cwd="$(pwd)"
    local targets=($(find "$cwd" -mindepth 1 -maxdepth 1 -type d))

    #==================== Sorting targets
    if [[ "$(find "$cwd" -mindepth 1 -maxdepth 1\
        -type f -name ".ord")" ]]
    then
        local order="$(cat ".ord")"
        local ordered=()
        while [[ "${#targets[@]}" -gt 0 ]];do
            if [[ ! "$order" ]];then
                ordered+=("${targets[0]}")
                targets=("${targets[@]:1}")
                continue
            fi
            local next="$(head -n1 <<< "$order")"
            if [[ ! -e "$next" ]];then
                echo -e "[$RED ERR $NC] $cwd/$next not found"
                return 1
            fi
            for target in "${targets[@]}";do
                local name="$(basename "$target")"
                if [[ "$name" == "$next" ]];then

                    ordered+=("$target")
                    targets=($(printf "%s\n" "${targets[@]}"\
                        | grep -v "^$target$"))
                    order="$(tail -n+2 <<< "$order")"
                    break
                fi
            done
        done
        targets=("${ordered[@]}")
    else
        targets=($(sort <<< "${targets[@]}"))
    fi

    if ! grep -q "$cwd/.git" <<< "${targets[@]}";then
    #==================== Not a git repository, go deeper
        for target in "${targets[@]}";do
            local name="$(basename "$target")"
            printf "%s\n" "${EXCLUDE[@]}" | grep -q "^$name$"\
                && continue
            cd "$target" || continue
            do_it
        done
        return 0
    fi

    local state="$(git status -s)"
    if [[ ! "$state" ]];then
    #==================== Nothing to commit
        ft_echo "$cwd [$GREEN OK $NC]\n"
        return 0
    fi

    ft_echo "${BLUE}Pushing${NC} $cwd...\n"
    git pull 1>"/dev/null" || return 1

    #==================== .add & .msg files
    if grep -q "$cwd/.add" <<< "${targets[@]}";then
        TO_ADD="$(cat ".add")"
        [[ "${#RM_ADD[@]}" -gt 0 ]]\
            && rm_it "${RM_ADD[@]}" "$cwd/.add"
    fi
    if grep -q "$cwd/.msg" <<< "${targets[@]}";then
        MESSAGE="$(cat ".msg")"
        [[ "${#RM_MSG[@]}" -gt 0 ]]\
            && rm_it "${RM_MSG[@]}" "$cwd/.msg"
    fi

    #==================== Add, commit & push
    for target in "${TO_ADD[@]}";do git add "$target";done
    ! git commit -m "$MESSAGE"\
        && ft_echo "[$RED KO $NC]\n" && return 1
    ! git push && ft_echo "[$RED KO $NC]\n" && return 1
    ft_echo "[$GREEN OK $NC]\n"

    [[ "$(git status -s)" ]]\
        && ft_echo "[$YELLOW WARN $NC] $cwd: Uncommitted changes\n"
}
rm_it(){
    local targets=("${@:1:$#-1}")
    local file="${@: -1}"
    local count="${#targets[@]}"
    [[ "$count" -eq 0 ]] && return 0

    if [[ "$count" -eq 1 && "${targets[0]}" == "*" ]];then
        rm "$file" || return 1
        return 0
    fi
    local dir="$(basename "$(dirname "$file")")"
    for target in "${targets[@]}";do
        if [[ "$target" == "$dir" ]];then
            rm "$file" || return 1
            return 0
        fi
    done
    return 1
}

ft_echo "$GRAY===================FROM: $ROOT$NC\n"
do_it
ft_echo "$GRAY===================DONE$NC\n"
