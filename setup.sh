#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

__mkdir() {
    mkdir -p "${HOME}/.config/zsh"
    mkdir -p "${HOME}/.local/script"
    mkdir -p "${HOME}/.local/share/applications"
}

__completion() {
    local _update="" _need_compinit=""
    case "${1}" in
        "--update" | "-u")
            shift
            _update="yes"
            ;;
    esac
    local _completion_dir="${SCRIPT_PATH}/.config/zsh/completion" _f

    _f="${_completion_dir}/ripgrep.zsh"
    if [ "${_update}" ] || [ ! -e "${_f}" ]; then
        # REF:
        #   https://man.archlinux.org/man/rg.1.en#SHELL_COMPLETION
        cp -f "/usr/share/zsh/site-functions/_rg" "${_f}"
        _need_compinit="yes"
    fi

    _f="${_completion_dir}/docker.zsh"
    if [ "${_update}" ] || [ ! -e "${_f}" ]; then
        # REF:
        #   https://docs.docker.com/config/completion/#zsh
        docker completion zsh >"${_f}"
        _need_compinit="yes"
    fi

    _f="${_completion_dir}/kubectl.zsh"
    if [ "${_update}" ] || [ ! -e "${_f}" ]; then
        # REF:
        #   https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion
        kubectl completion zsh >"${_f}"
        _need_compinit="yes"
    fi

    _f="${_completion_dir}/minikube.zsh"
    if [ "${_update}" ] || [ ! -e "${_f}" ]; then
        # REF:
        #   https://minikube.sigs.k8s.io/docs/commands/completion/#minikube-completion-zsh
        minikube completion zsh >"${_f}"
        _need_compinit="yes"
    fi

    _f="${_completion_dir}/pipx.zsh"
    if [ "${_update}" ] || [ ! -e "${_f}" ]; then
        # REF:
        #   https://pipx.pypa.io/latest/docs/#pipx-completions
        register-python-argcomplete pipx >"${_f}"
        _need_compinit="yes"
    fi

    _f="${HOME}/.config/zsh/.zcompdump"
    __compinit() {
        zsh -c "autoload -Uz compinit && compinit"
    }
    if [ ! -e "${_f}" ]; then
        __compinit
        return
    fi
    if [ "${_need_compinit}" ]; then
        rm "${_f}" && __compinit
    fi
}

__stow() {
    (
        cd .. && stow -R "$(basename "${SCRIPT_PATH}")"
    )
}

__mkdir
__completion "${@}"
__stow
