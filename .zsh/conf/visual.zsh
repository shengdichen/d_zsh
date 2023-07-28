function __cursor_config() {
    # use steady, beam-style cursor
    echo -ne "\e[6 q"
}

function __prompt_config() {
    # common elements:
    #   %h OR %!
    #       ->  current history event number, i.e., "line number"
    #   %?
    #       ->  exit code of previous command
    #   %S/%s
    #       ->  turn on/off standout
    #   %F
    #       ->  use custom format
    #   %(?.<command_if_true>.<command_if_false>)

    # NOTE:
    # remember to always reset formatting before concluding the prompt; the
    # command input would otherwise bear the same formatting

    if [ $SHLVL -gt 3 ]; then
        PROMPT="%F{015}%#%F{none} "
    else
        PROMPT="%S%F{015}%#%s%F{none} "
    fi

    RPROMPT="%(?..%S%F{009}%?)%s%F{none}"
}

function main() {
    __cursor_config
    __prompt_config

    unfunction __cursor_config __prompt_config
}
main
unfunction main

# vim: filetype=zsh
