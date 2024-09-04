#!/usr/bin/env dash

__nohup() {
    nohup "${@}" >/dev/null 2>&1 &
}

__x() {
    nohup "${@}" >/dev/null 2>&1 &
}

__x_11() {
    WAYLAND_DISPLAY="" nohup "${@}" >/dev/null 2>&1 &
}

__nvim() {
    local _mode=""
    if [ "${1}" = "--mode" ]; then
        _mode="${2}"
        shift 2
    fi
    if [ "${1}" = "--" ]; then shift; fi

    if [ ! "${_mode}" ]; then
        if [ "${#}" -eq 0 ]; then
            nvim
            return
        fi
        nvim -O "${@}"
        return
    fi

    case "${_mode}" in
        "diff")
            if [ "${#}" -eq 0 ]; then
                nvim -d
                return
            fi
            nvim -d "${@}"
            ;;
        "ro")
            if [ "${#}" -eq 0 ]; then
                nvim -R -c "set nomodifiable"
                return
            fi
            nvim -R -c "set nomodifiable" "${@}"
            ;;
    esac
}

__unflatten() {
    if [ "${#}" -eq 0 ]; then
        cat
        return
    fi

    local _e
    for _e in "${@}"; do
        printf "%s\n" "${_e}"
    done
}

__fzf() {
    local _multi _height="73%"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--multi")
                _multi="yes"
                shift
                ;;
            "--height")
                _height="${2}%"
                shift 2
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    if [ "${_multi}" ]; then
        __unflatten "${@}" | fzf \
            --multi \
            --reverse \
            --height "${_height}" \
            2>/dev/tty
        return
    fi

    __unflatten "${@}" | fzf \
        --reverse \
        --height "${_height}" \
        2>/dev/tty
}

__separator() {
    local _length=37 _char="-"
    local _n_linebreaks_before=1 _n_linebreaks_after=1
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--length")
                _length="${2}"
                shift 2
                ;;
            "--char")
                if [ "${2}" = "%" ]; then
                    _char="%%" # escape % for printf
                else
                    _char="${2}"
                fi
                shift 2
                ;;
            "--breaks-before")
                _n_linebreaks_before="${2}"
                shift 2
                ;;
            "--breaks-after")
                _n_linebreaks_after="${2}"
                shift 2
                ;;
        esac
    done

    if [ "${_n_linebreaks_before}" -gt 0 ]; then
        printf -- "%0.s\n" $(seq 1 "${_n_linebreaks_before}")
    fi

    printf -- "%0.s${_char}" $(seq 1 "${_length}")
    printf "\n"

    if [ "${_n_linebreaks_after}" -gt 0 ]; then
        printf -- "%0.s\n" $(seq 1 "${_n_linebreaks_after}")
    fi
}

__fzf_opts() {
    local _is_first_opt="yes" _choice _opt
    if ! _choice="$(
        for _opt in "${@}"; do
            if [ "${_is_first_opt}" ]; then
                printf "%s  // default\n" "${_opt}"
                _is_first_opt=""
                continue
            fi
            printf "%s\n" "${_opt}"
        done | __fzf
    )"; then
        _choice="${1}"
    fi
    printf "%s" "${_choice}" | cut -d " " -f "1"
}

__find_here() {
    find -L "./" -mindepth 1 -printf "%P\n" | sort -n
}

__yes_or_no() {
    if [ "${1}" = "--" ]; then shift; fi

    local _input
    while true; do
        printf "%s [y]es; [n]o? " "${1:-"choice/binary>"}"
        read -r _input

        case "${_input}" in
            "y" | "Y" | "yes")
                return 0
                ;;
            "n" | "N" | "no")
                return 1
                ;;
            *)
                printf "help> [y] for yes; [n] for no\n\n"
                ;;
        esac
    done
}

__is_root() {
    [ "$(id -u)" -eq 0 ]
}

__sudo() {
    if ! __is_root; then
        printf "sudo"
        return
    fi
}

__pkill() {
    pkill -f "${@}"
}

__pgrep() {
    pgrep \
        -u "$(id -u)" \
        -f "${1}" \
        >/dev/null
}
