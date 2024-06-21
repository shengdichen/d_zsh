#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

__setup() {
    mkdir -p "${HOME}/.config/zsh"
    mkdir -p "${HOME}/.local/script"
    mkdir -p "${HOME}/.local/share/applications"
}

__stow() {
    (
        cd .. && stow -R "$(basename "${SCRIPT_PATH}")"
    )
}

__setup
__stow
