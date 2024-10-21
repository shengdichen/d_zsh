#!/usr/bin/env dash

SOURCE_SYNC="${SOURCE_SYNC}:-nist"

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

__timezone() {
    local _zone_dir="/usr/share/zoneinfo" _zonefile

    case "$(__fzf_opts "vaduz" "hk" "ny" "Москва" "manual")" in
        "vaduz")
            _zonefile="${_zone_dir}/Europe/Vaduz"
            ;;
        "hk")
            _zonefile="${_zone_dir}/Asia/Hong_Kong"
            ;;
        "ny")
            _zonefile="${_zone_dir}/America/New_York"
            ;;
        "Москва")
            _zonefile="${_zone_dir}/Europe/Moscow"
            ;;
        "manual")
            __f() {
                (
                    cd "${_zone_dir}" || exit 3

                    local _t
                    find -L "./" -mindepth 1 -printf "%P\n" | sort -n | while read -r _t; do
                        if [ ! -d "${_t}" ]; then
                            printf "%s\n" "${_t}"
                        fi
                    done | __fzf
                )
            }
            _zonefile="${_zone_dir}/$(__f)"
            ;;
    esac

    sudo ln -sf "${_zonefile}" "/etc/localtime"
}

__sync() {
    printf "time/pre> %s\n" "$(__print --less)"

    local _date_pattern="Date: "
    local _source
    case "${SOURCE_SYNC}" in
        "google")
            _source="http://google.com"
            ;;
        *)
            _source="https://nist.time.gov"
            ;;
    esac

    "$(__sudo)" date -s "$(
        curl -s --head "${_source}" |
            grep "^${_date_pattern}" |
            sed "s/${_date_pattern}//g"
    )" >/dev/null
    "$(__sudo)" hwclock -w --utc

    printf "\n"
    printf "time/post> %s\n" "$(__print --less)"
}

case "${1}" in
    "zone")
        __timezone
        ;;
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
