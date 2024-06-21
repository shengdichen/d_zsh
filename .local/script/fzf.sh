#!/usr/bin/env dash

SEPARATOR=":::" # a separator unlikely found in filenames

__rg() {
    rg \
        --hidden \
        --color never --no-heading --with-filename --line-number \
        --field-match-separator "${SEPARATOR}" \
        ".*" -- "${@}"
}

__fzf() {
    fzf --reverse --height=73% 2>/dev/tty
}

__to_line() {
    local _res _line _file

    if _res="$(
        if [ "${#}" -gt 0 ]; then
            __rg "${@}"
        else
            __rg .
        fi |
            sed "s/^\.\///" | # hide (possible) leading "./"
            __fzf
    )"; then
        _file="$(printf "%s" "${_res}" | awk -F "${SEPARATOR}" "{print \$1}")"
        _line="$(printf "%s" "${_res}" | awk -F "${SEPARATOR}" "{print \$2}")"
        nvim +"${_line}" -- "${_file}"
    fi
}

__to_line "${@}"
