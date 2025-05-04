#!/usr/bin/env dash

__mime() {
    file --brief --mime-type --dereference -- "${1}"
}

__filter_valid() {
    local _candidate

    __f() {
        [ -e "${1}" ] && printf "%s\n" "${1}"
    }

    if [ "${#}" -eq 0 ]; then
        while read -r _candidate; do
            __f "${_candidate}"
        done
        return
    fi

    for _candidate in "${@}"; do
        if [ "${_candidate}" = "-" ]; then
            while read -r _candidate; do
                __f "${_candidate}"
            done
            continue
        fi
        __f "${_candidate}"
    done

    unset -f __f
}

__check_aud() {
    local _mode="both"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--mode")
                _mode="${2}"
                shift 2
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    __name() {
        case "${1}" in
            *".flac" | *".wav" | *".ape" | \
                *".mp3" | *.m4[ab] | \
                *".wma" | *".ac3" | *.og[agx] | *".spx" | *".opus")
                return
                ;;
        esac
        return 1
    }

    __mime_ready() {
        case "${1}" in
            "audio/"*)
                return
                ;;
        esac
        return 1
    }

    __mime_adhoc() {
        __mime_ready "$(__mime "${1}")"
    }

    case "${_mode}" in
        "name")
            __name "${1}"
            ;;
        "mime-ready")
            __mime_ready "${1}"
            ;;
        "mime-adhoc")
            __mime_adhoc "${1}"
            ;;
        "both")
            __name "${1}" || __mime_adhoc "${1}"
            ;;
    esac
}

__check_vid() {
    local _mode="both"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--mode")
                _mode="${2}"
                shift 2
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    __name() {
        case "${1}" in
            *".mkv" | \
                *".avi" | *".mp4" | *".webm" | *".ts" | *.m[4o]v | \
                *".mpg" | *".mpeg" | *".vob" | *.fl[icv] | \
                *".wmv" | *".dat" | *".3gp" | *".ogv" | *".m2v" | *".mts" | \
                *.r[am] | *".qt" | *".divx" | *.as[fx])
                return
                ;;
        esac
        return 1
    }

    __mime_ready() {
        case "${1}" in
            "video/"*)
                return
                ;;
        esac
        return 1
    }

    __mime_adhoc() {
        __mime_ready "$(__mime "${1}")"
    }

    case "${_mode}" in
        "name")
            __name "${1}"
            ;;
        "mime-ready")
            __mime_ready "${1}"
            ;;
        "mime-adhoc")
            __mime_adhoc "${1}"
            ;;
        "both")
            __name "${1}" || __mime_adhoc "${1}"
            ;;
    esac
}

__check_media() {
    local _mode="both"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--mode")
                _mode="${2}"
                shift 2
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    __name() {
        __check_aud --mode name -- "${1}" || __check_vid --mode name -- "${1}"
    }

    __mime_ready() {
        local _mime
        _mime="$(__mime "${1}")"
        __check_aud --mode mime-ready -- "${_mime}" || __check_vid --mode mime-ready -- "${_mime}"
    }

    __mime_adhoc() {
        __mime_ready "$(__mime "${1}")"
    }

    case "${_mode}" in
        "name")
            __name "${1}"
            ;;
        "mime-ready")
            __mime_ready "${1}"
            ;;
        "mime-adhoc")
            __mime_adhoc "${1}"
            ;;
        "both")
            __name "${1}" || __mime_adhoc "${1}"
            ;;
    esac
}

__filter_aud() {
    local _candidate _f

    __filter_valid "${@}" | while read -r _candidate; do
        if [ ! -d "${_candidate}" ]; then
            if __check_aud -- "${_candidate}"; then
                printf "%s\n" "${_candidate}"
            fi
            continue
        fi

        find -L "${_candidate}" -mindepth 1 -type f | sort -n | while read -r _f; do
            if __check_aud -- "${_f}"; then
                printf "%s\n" "${_f}"
            fi
        done
    done
}

__filter_vid() {
    local _candidate _f

    __filter_valid "${@}" | while read -r _candidate; do
        if [ ! -d "${_candidate}" ]; then
            if __check_vid -- "${_candidate}"; then
                printf "%s\n" "${_candidate}"
            fi
            continue
        fi

        find -L "${_candidate}" -mindepth 1 -type f | sort -n | while read -r _f; do
            if __check_vid -- "${_f}"; then
                printf "%s\n" "${_f}"
            fi
        done
    done
}

__filter_media() {
    local _candidate _f

    __filter_valid "${@}" | while read -r _candidate; do
        if [ ! -d "${_candidate}" ]; then
            if __check_media -- "${_candidate}"; then
                printf "%s\n" "${_candidate}"
            fi
            continue
        fi

        find -L "${_candidate}" -mindepth 1 -type f | sort -n | while read -r _f; do
            if __check_media -- "${_f}"; then
                printf "%s\n" "${_f}"
            fi
        done
    done
}
