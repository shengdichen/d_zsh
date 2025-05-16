#!/usr/bin/env bash

. "${HOME}/.local/lib/util.sh"

__link_hard() {
    if [ "${1}" = "--" ]; then shift; fi
    for _p in "${@}"; do
        printf "link/hard> %s\n" "${_p}"
        cp -al "${_p}" ".."
    done
}

__size() {
    if [ "${1}" = "--" ]; then shift; fi
    for _target in "${@}"; do
        du --human-readable --total -- "${_target}"
        printf "\n"
    done | __nvim --mode ro
}

__find() {
    if [ "${1}" = "--" ]; then shift; fi
    find "${1}" -mindepth 1 -printf "%P\n"
}

__make_pipe() {
    if [ ! -e "${1}" ]; then
        mkfifo "${1}"
    elif [ ! -p "${1}" ]; then
        rm "${1}"
        mkfifo "${1}"
    fi
}

__diff() {
    if [ "${1}" = "--" ]; then shift; fi

    if [ -d "${1}" ] && [ -d "${2}" ]; then
        __nvim --mode diff <(__find "${1}") <(__find "${2}")
    elif [ -f "${1}" ] && [ -f "${2}" ]; then
        __nvim --mode diff "${@}"
    else
        printf "diff> mix-match of dir & file, exiting "
        read -r _
    fi
}

__main() {
    case "$(__select_opt "link/hard" "size" "diff")" in
        "link/hard")
            shift
            __link_hard "${@}"
            ;;
        "size")
            shift
            __size "${@}"
            ;;
        "diff")
            shift
            __diff "${@}"
            ;;
    esac
}
__main "${@}"
