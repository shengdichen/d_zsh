function _source_recursive() {
    for f in "${ZDOTDIR}"/"$1"/**/*.zsh; do
        source "${f}"
    done
}
_source_recursive "conf"
_source_recursive "common"

unfunction _source_recursive
