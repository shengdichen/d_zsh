alias c='clear'
alias q='exit'

alias fh='free -h'

# NOTE: unlike bash, NO extra setup necessary for auto-completion
alias g='git'

alias m='make'

# ag->fzf->nvim
alias afn="\
    ag \
        --line-numbers --noheading --nobreak \
        --hidden --unrestricted \
        . \
    | \
    fzf \
    | \
    awk \
        -F : \
        '{cmd=\"nvim +\"\$2\" -- \"\$1; system(cmd)}' \
    "

# vim: filetype=zsh foldmethod=marker
