__x() {
    nohup "${@}" >/dev/null 2>&1 &
    disown
}

__x_11() {
    WAYLAND_DISPLAY="" nohup "${@}" >/dev/null 2>&1 &
    disown
}

__mpv_paste() {
    local _path _input
    while true; do
        _path="$(wl-paste)"
        printf "mpv-paste> [%s], go ahead? [y]es (default), [n]o " "${_path}"
        read -r _input
        case "${_input}" in
            "n" | "N")
                printf "mpv-paste> recopy to proceed "
                read -r _
                printf "\n"
                ;;
            *)
                printf "mpv-paste> launching...\n"
                __x mpv -- "${_path}"

                printf "\n"
                printf "mpv-paste> break? [y]es (default), [n]o "
                read -r _input
                case "${_input}" in
                    "n" | "N")
                        printf "\n"
                        ;;
                    *)
                        printf "mpv-paste> quiting\n"
                        break
                        ;;
                esac
                ;;
        esac
    done
}
