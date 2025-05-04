#!/usr/bin/env bash

. "${HOME}/.local/lib/util.sh"

declare -a _OPTS=() _ARGS_STDIN=() _ARGS_CMDLN=() _ARGS=()

__process() {
    _OPTS=()
    _ARGS_STDIN=()
    _ARGS_CMDLN=()
    _ARGS=()

    local _item
    if [ "${#}" -eq 0 ]; then
        while read -r _item; do
            _ARGS_STDIN+=("${_item}")
            _ARGS+=("${_item}")
        done
        return
    fi

    local _current_is_opt=""
    if __is_in "--" "${@}"; then
        _current_is_opt="yes"
    fi

    if __is_in "-" "${@}"; then
        while read -r _item; do
            _ARGS_STDIN+=("${_item}")
        done
    fi

    for _item in "${@}"; do
        if [ "${_item}" = "--" ]; then
            _current_is_opt=""
            continue
        fi

        if [ "${_current_is_opt}" ]; then
            _OPTS+=("${_item}")
            continue
        fi

        if [ "${_item}" = "-" ]; then
            _ARGS+=("${_ARGS_STDIN[@]}")
            continue
        fi

        _ARGS_CMDLN+=("${_item}")
        _ARGS+=("${_item}")
    done
}
