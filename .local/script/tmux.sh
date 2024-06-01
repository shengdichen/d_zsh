#!/usr/bin/env dash

__tmux_running() {
    pgrep -u "$(id -u)" -f "^tmux .*start" 1>/dev/null
}

__tmux_start() {
    printf "tmux> launching...\n"
    tmux -2 start-server
    tmux source-file "${HOME}/.config/tmux/script/launch.tmux"
}

__tmux_attach() {
    if [ ! "${TMUX}" ]; then
        local _session
        _session="$(tmux list-sessions -F "#{session_name}" | fzf --reverse)"
        tmux attach-session -t "${_session}"
    else
        printf "tmux> already in tmux, done!\n"
    fi
}

case "${1}" in
    "run")
        if ! __tmux_running; then
            __tmux_start
        else
            __tmux_attach
        fi
        ;;
    *) ;;
esac
