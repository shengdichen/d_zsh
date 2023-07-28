function __set_basic() {
    export EDITOR="nvim"
}

function __set_path() {
    local LOCAL="${HOME}/.local"

    local LOCAL_BIN="${LOCAL}/bin"
    export npm_config_prefix="${LOCAL}"  # ./bin auto-appended

    # remove duplications
    typeset -U path
    path=("${LOCAL_BIN}" ${path})
}

function __set_manpath() {
    # use nvim with |Man| plugin as pager for man
    export MANPAGER="nvim +Man!"

    local LOCAL="${HOME}/.local"
    local LOCAL_MAN="${LOCAL}/share/man"
    # safely append the man-path to npm's packages by preserving MANPATH if already
    # defined, otherwise by "sourcing" it with |$ manpath|
    export MANPATH="${MANPATH-$(manpath)}:${LOCAL_MAN}"
}

function __set_ime() {
    export GTK_IM_MODULE="fcitx"
    export QT_IM_MODULE="fcitx"
    export XMODIFIERS=@im="fcitx"
}

function __set_gpg() {
    # for shell invocation of gpg
    export GPG_TTY=$(tty)
}

function __set_fzf() {
    export FZF_COMPLETION_TRIGGER="jk"

    export FZF_COMPLETION_OPTS="\
        --border=none \
        --prompt='% ' \
        --info=inline:' <<  ' \
    "
}

function main() {
    __set_basic
    __set_path
    __set_manpath
    __set_ime
    __set_gpg
    __set_fzf

    unfunction __set_basic __set_path __set_manpath __set_ime __set_gpg __set_fzf
}
main
unfunction main
