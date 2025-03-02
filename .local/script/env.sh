#!/usr/bin/env dash

__tmux_env_set() {
    tmux set-environment -g "${@}"
}

__wayland_display() {
    printf "env> wayland-display := '%s'\n" "${WAYLAND_DISPLAY}"
    __tmux_env_set "WAYLAND_DISPLAY" "${WAYLAND_DISPLAY}"
}

__sway() {
    printf "env> swaysock := '%s'\n" "${SWAYSOCK}"
    __tmux_env_set "SWAYSOCK" "${SWAYSOCK}"
}

__wayland_display
__sway
