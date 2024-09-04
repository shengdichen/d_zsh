#!/usr/bin/env dash

. "${HOME}/.local/lib/util.sh"

__print() {
    __more() {
        date "+%Y.%b.%d" | toilet -f future
        date "+%p, %V->%a; %Z@%z"
        date "+%H:%M:%S" | toilet -f future --metal | lolcat
    }

    __default() {
        date "+%Y.%b.%d-%H:%M:%S" | toilet -f future --metal | lolcat
    }

    __less() {
        date "+%Y.%b.%d-%H:%M:%S"
    }

    case "${1}" in
        "--more")
            __more
            ;;
        "--less")
            __less
            ;;
        *)
            __default
            ;;
    esac
}

__sync() {
    printf "time/pre> %s\n" "$(__print --less)"

    local _date_pattern="Date: "
    "$(__sudo)" date -s "$(
        curl -s --head "http://google.com" |
            grep "^${_date_pattern}" |
            sed "s/${_date_pattern}//g"
    )" >/dev/null
    "$(__sudo)" hwclock -w --utc

    printf "\n"
    printf "time/post> %s\n" "$(__print --less)"
}

case "${1}" in
    "sync")
        __sync
        ;;
    "print")
        shift
        __print "${@}"
        ;;
    *)
        __print
        ;;
esac
