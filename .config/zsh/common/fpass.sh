#!/usr/bin/env dash

PASS_DIR="password-store" # intentionally without leading dot
CLIPBOARD_TIME=7          # in second(s)

__fpass() {
    local _target
    _target=$(
        find -L "${HOME}/.${PASS_DIR}/" -type f | grep -e "\.gpg$" | fzf |
            sed "s/^.*\.${PASS_DIR}\/\(.*\)\.gpg$/\1/"
    )

    case "${_target}" in
        *".mfa")
            PASSWORD_STORE_CLIP_TIME="${CLIPBOARD_TIME}" \
                pass otp code -c "${_target}" 1>/dev/null
            ;;
        *)
            echo -n "(s)how, (e)dit, copy (default)? "
            read -r mode
            if [ "${mode}" = "s" ]; then
                pass show "${_target}" | "${EDITOR}" -R
            elif [ "${mode}" = "e" ]; then
                pass edit "${_target}" 2>/dev/null
                if [ "${?}" -eq 1 ]; then
                    return 0 # pass returns 1 if no changes made
                fi
            else
                PASSWORD_STORE_CLIP_TIME="${CLIPBOARD_TIME}" \
                    pass -c "${_target}" 1>/dev/null
            fi
            ;;
    esac
}

case "${1}" in
    "run")
        shift
        __fpass
        ;;
    *) ;;
esac
