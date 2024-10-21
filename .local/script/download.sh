#!/usr/bin/env dash

__tidal() {
    __f() {
        tidal-dl -l "${1}"
    }

    if [ "${1}" = "--" ]; then shift; fi
    if [ "${#}" = 0 ]; then
        __f "$(wl-paste)"
    fi

    local _item
    for _item in "${@}"; do
        __f "${_item}"
    done

    unset -f __f
}

__ytdlp() {
    local _resolution="1080"
    local _format_audio="bestaudio[ext=m4a]"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--resolution")
                case "${2}" in
                    "2k" | "2K")
                        _resolution="1440"
                        ;;
                    "4k" | "4K")
                        _resolution="2160"
                        ;;
                    *)
                        _resolution="${2}"
                        ;;
                esac
                shift 2
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    local _format="${_format_audio}"
    if [ "${_resolution}" != 0 ]; then
        _format="bestvideo[height<=${_resolution}]+${_format}"
    fi

    yt-dlp \
        --quiet --progress \
        --format "${_format}" \
        "${@}"
}

__audiobook() {
    __ytdlp --resolution 0 "${@}"
}

__audio() {
    __ytdlp --resolution 0 "${@}"
}

__video() {
    __ytdlp "${@}"
}

__main() {
    case "${1}" in
        "tidal")
            shift
            __tidal "${@}"
            ;;
        "audiobook")
            shift
            __audiobook "${@}"
            ;;
        "audio")
            shift
            __audio "${@}"
            ;;
        "video")
            shift
            __video "${@}"
            ;;
        *)
            __ytdlp "${@}"
            ;;
    esac
}
__main "${@}"
