function __alias_common() {
    alias c="clear"
    alias q="exit"

    alias fh="free -h"

    # NOTE: unlike bash, NO extra setup necessary for auto-completion
    alias g="git"

    alias m="make"
}

function __alias_man() {
    alias man_fr="man -L fr_FR.UTF-8"
    alias man_ru="man -L ru_RU.UTF-8"
    alias man_de="man -L de_DE.UTF-8"
    alias man_es="man -L es_ES.UTF-8"
    alias man_pt="man -L pt_BR.UTF-8"
    alias man_it="man -L it_IT.UTF-8"
    alias man_sv="man -L sv_SV.UTF-8"
    alias man_zh="man -L zh_TW.UTF-8"
}

function __ag_to_fzf_to_editor() {
    alias afe="\
        ag \
            --line-numbers --noheading \
            --hidden \
            . \
        | \
        fzf \
        | \
        awk \
            -F : \
            '{cmd=\"\$EDITOR +\"\$2\" -- \"\$1; system(cmd)}' \
    "
}

function main() {
    __alias_common
    __alias_man
    __ag_to_fzf_to_editor

    unfunction __alias_common __alias_man __ag_to_fzf_to_editor
}
main
unfunction main
