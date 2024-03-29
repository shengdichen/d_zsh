function __fzf_config() {
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh

    # NOTE:
    #   1. first unbind default M-c for cd'ing
    bindkey -M vicmd -r "\ec"
    bindkey -M viins -r "\ec"
    bindkey -M vicmd "^Y" fzf-cd-widget
    bindkey -M viins "^Y" fzf-cd-widget
}

function __load_zsh_highlighter () {
    local target="\
/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\
"

    [[ -e "${target}" ]] && source "${target}"
}

function __set_gpg() {
    # force tty-mode of gpg-agent
    export GPG_TTY=$(tty)
}


function main() {
    __fzf_config
    __load_zsh_highlighter
    __set_gpg

    unfunction __fzf_config __load_zsh_highlighter __set_gpg
}
main
unfunction main
