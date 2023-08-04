function __fzf_config() {
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh

    bindkey -M vicmd -r "\ec"
    bindkey -M viins -r "\ec"
    bindkey -M vicmd '^Y' fzf-cd-widget
    bindkey -M viins '^Y' fzf-cd-widget
}

function __load_zsh_highlighter () {
    local path_zsh_highlighter=\
/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    [[ -e "${path_zsh_highlighter}" ]] && source "${path_zsh_highlighter}"
}

function main() {
    __fzf_config
    __load_zsh_highlighter

    unfunction __fzf_config __load_zsh_highlighter
}
main
unfunction main
