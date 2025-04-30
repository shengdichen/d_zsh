#!/usr/bin/env dash

. "${HOME}/.local/lib/util.sh"

__to_line() {
    local _vifm=""
    if [ "${1}" = "vifm" ]; then
        _vifm="yes"
        shift
    fi
    if [ "${1}" = "--" ]; then shift; fi

    # a separator unlikely found in filenames
    local _separator=":::"

    __rg() {
        if [ "${#}" -eq 0 ]; then
            rg \
                --hidden --follow --glob "!.git/*" \
                --color never --no-heading --with-filename --line-number \
                --field-match-separator "${_separator}" \
                ".*" -- .
            return
        fi
        rg \
            --hidden --follow --glob "!.git/*" \
            --color never --no-heading --with-filename --line-number \
            --field-match-separator "${_separator}" \
            ".*" -- "${@}"
    }

    local _res
    if ! _res="$(__rg "${@}" | cut -c "3-" | __fzf --height 97)"; then # cut: hide leading "./"
        return
    fi

    local _file
    _file="$(printf "%s" "${_res}" | awk -F "${_separator}" "{print \$1}")"
    if [ "${_vifm}" ]; then
        printf "%s" "${_file}" # vifm-plugin canNOT handle linenumber
        return
    fi

    local _line
    _line="$(printf "%s" "${_res}" | awk -F "${_separator}" "{print \$2}")"
    nvim "+${_line}" -- "${_file}"
}

__to_path() {
    local _type=""
    case "${1}" in
        "dir")
            _type="d"
            shift
            ;;
        "file")
            _type="f"
            shift
            ;;
    esac

    local _path
    if [ "${#}" -eq 0 ]; then
        _path="."
    else
        _path="${1}"
        shift
    fi

    if [ ! "${_type}" ]; then
        __find --no-sort --path "${_path}" -- -printf "%P\n" "${@}"
    else
        __find --no-sort --path "${_path}" -- -type "${_type}" -printf "%P\n" "${@}" |
            if [ "${_type}" = "d" ]; then
                sed "s/\(.*\)/\1\//"
            else
                cat -
            fi
    fi | __fzf
}

case "${1}" in
    "dir")
        shift
        __to_path dir "${@}"
        ;;
    "file")
        shift
        __to_path file "${@}"
        ;;
    "vifm")
        shift
        __to_line vifm "${@}"
        ;;
    *)
        __to_line "${@}"
        ;;
esac
