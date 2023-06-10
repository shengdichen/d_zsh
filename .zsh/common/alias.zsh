alias c='clear'
alias q='exit'

alias fh='free -h'

# NOTE: unlike bash, NO extra setup necessary for auto-completion
alias g='git'

alias m='make'

# ag->fzf->EDITOR
alias afe="\
    ag \
        --line-numbers --noheading --nobreak \
        --hidden --unrestricted \
        . \
    | \
    fzf \
    | \
    awk \
        -F : \
        '{cmd=\"\$EDITOR +\"\$2\" -- \"\$1; system(cmd)}' \
"

# vim: filetype=zsh foldmethod=marker
