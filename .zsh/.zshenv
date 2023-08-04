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

function __set_manpager() {
    export MANPAGER="nvim +Man!"
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
    __set_manpager
    __set_ime
    __set_gpg
    __set_fzf

    unfunction __set_basic __set_path __set_manpager __set_ime __set_gpg __set_fzf
}
main
unfunction main
