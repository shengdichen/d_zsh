function __fzf_config() {
    local _base=""
    if [ "${TERMUX_VERSION}" ]; then
        _base="/data/data/com.termux/files"
    fi
    local _f
    for _f in "key-bindings" "completion"; do
        source "${_base}/usr/share/fzf/${_f}.zsh"
    done

    # NOTE:
    #   1. first unbind default M-c for cd'ing
    bindkey -M vicmd -r "\ec"
    bindkey -M viins -r "\ec"
    bindkey -M vicmd "^Y" fzf-cd-widget
    bindkey -M viins "^Y" fzf-cd-widget
}

function __plugins() {
    local _target _base="/usr/share/zsh/plugins/"
    for _target in \
        "${_base}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
        "${_base}/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
        [ -e "${_target}" ] && source "${_target}"
    done
    bindkey "^ " autosuggest-accept
}

function __set_gpg() {
    # REF:
    #   https://wiki.archlinux.org/title/GnuPG#Configure_pinentry_to_use_the_correct_TTY

    # force tty-mode of gpg-agent
    export GPG_TTY=$(tty)
}

function main() {
    __fzf_config
    __plugins
    __set_gpg

    unfunction __fzf_config __plugins __set_gpg
}
main
unfunction main
