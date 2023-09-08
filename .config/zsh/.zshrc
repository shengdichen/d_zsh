function __source_recursive() {
    for f in "${ZDOTDIR}"/"$1"/**/*.zsh; do
        source "${f}"
    done
}

__source_recursive "conf"
__source_recursive "common"
unfunction __source_recursive
