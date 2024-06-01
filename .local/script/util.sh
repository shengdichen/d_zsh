#!/usr/bin/env dash

__x() {
    nohup "${@}" >/dev/null 2>&1 &
}

__x_11() {
    WAYLAND_DISPLAY="" nohup "${@}" >/dev/null 2>&1 &
}
