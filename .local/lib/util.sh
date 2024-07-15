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

__fzf() {
    fzf --reverse --height=73% 2>/dev/tty
}

__fzf_opts() {
    local _choice
    if ! _choice="$(
        for _opt in "${@}"; do printf "%s\n" "${_opt}"; done | __fzf
    )"; then
        _choice="${1}"
    fi
    printf "%s" "${_choice}"
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
