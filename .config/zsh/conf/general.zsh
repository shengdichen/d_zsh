function __bind_vi() {
    # use vicmd & viins
    bindkey -v

    bindkey -M viins "JJ" vi-cmd-mode
}

function __history() {
    HISTFILE="${ZDOTDIR}/.histfile"
    HISTSIZE=1000
    SAVEHIST=1000

    setopt histignoredups
    setopt histignorespace
}

function __misc_config() {
    # spare leading |cd|
    setopt autocd

    # emit beep/flash on error
    setopt beep
}

function main() {
    __bind_vi
    __history
    __misc_config

    unfunction __bind_vi __history __misc_config
}
main
unfunction main
