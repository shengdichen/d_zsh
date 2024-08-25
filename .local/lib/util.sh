#!/usr/bin/env dash

__nohup() {
    nohup "${@}" 1>/dev/null 2>&1 &
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

__fzf() {
    local _multi _height="73%"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--multi")
                _multi="yes"
                shift 1
                ;;
            "--height")
                _height="${2}%"
                shift 2
                ;;
        esac
    done

    if [ "${_multi}" ]; then
        fzf \
            --multi \
            --reverse \
            --height="${_height}" \
            2>/dev/tty
    else
        fzf \
            --reverse \
            --height="${_height}" \
            2>/dev/tty
    fi
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
    local _is_first_opt="yes" _choice
    if ! _choice="$(
        for _opt in "${@}"; do
            if [ "${_is_first_opt}" ]; then
                printf "%s  // default\n" "${_opt}"
                _is_first_opt=""
            else
                printf "%s\n" "${_opt}"
            fi
        done | __fzf
    )"; then
        _choice="${1}"
    fi
    printf "%s" "${_choice}" | cut -d " " -f "1"
}

__is_root() {
    [ "$(id -u)" -eq 0 ]
}

__sudo() {
    local _s=""
    if ! __is_root; then
        _s="sudo"
    fi
    printf "%s" "${_s}"
}

__pkill() {
    pkill -f "${@}"
}
