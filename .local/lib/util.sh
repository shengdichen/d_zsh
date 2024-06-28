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

__is_root() {
    [ "$(id -u)" -eq 0 ]
}

__sudo() {
    local s=""
    if ! __is_root; then
        s="sudo"
    fi
    echo "${s}"
}

__pkill() {
    pkill -f "${@}"
}
