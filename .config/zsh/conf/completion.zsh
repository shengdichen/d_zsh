function __basic() {
    # REF:
    #   https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Initialization
    local _completion_dir="${HOME}/.config/zsh/completion"
    fpath=("${_completion_dir}/docker.zsh" ${fpath})

    autoload -Uz compinit
    compinit

    setopt extendedglob
    setopt globdots # also match dot-files
    setopt nomatch
}

function __menu_like() {
    # enable menu-like completion
    zstyle ':completion:*' menu select

    zmodload zsh/complist
    bindkey -M menuselect "g" beginning-of-history
    bindkey -M menuselect "G" end-of-history

    bindkey -M menuselect "0" beginning-of-line
    bindkey -M menuselect '$' end-of-line

    bindkey -M menuselect "h" backward-char
    bindkey -M menuselect "j" down-line-or-search
    bindkey -M menuselect "k" up-line-or-search
    bindkey -M menuselect "l" forward-char

    bindkey -M menuselect "/" history-incremental-search-forward
    bindkey -M menuselect "?" history-incremental-search-backward

    bindkey -M menuselect "t" accept-and-hold # select multiple

    bindkey -M menuselect "u" undo
}

function main() {
    __basic
    __menu_like

    unfunction __basic __menu_like
}
main
unfunction main
