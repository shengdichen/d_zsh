function __cursor_config() {
    # use steady, beam-style cursor
    echo -ne "\e[6 q"
}

function __prompt_config() {
    # NOTE:
    #   %K/%k -> custom/default background
    #   %F/%f -> custom/default foreground
    #   %S/%s -> on/off standout-mode (inverse back-&foreground)
    #
    #   %(<test>.<output_if_true>.<output_if_false>)
    #   %? -> exit code of previous command
    #
    # REF:
    #   https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

    PROMPT="%S%#%s "

    RPROMPT="\
%(?.
.\
%K{red}%F{black}%?\
)\
%k%f\
"
}

function main() {
    __cursor_config
    __prompt_config

    unfunction __cursor_config __prompt_config
}
main
unfunction main
