export EDITOR="nvim"

function set_path() {
    LOCAL="${HOME}/.local"

    LOCAL_BIN="${LOCAL}/bin"
    export npm_config_prefix="${LOCAL}"  # ./bin auto-appended

    # remove duplications
    typeset -U path
    path=("${LOCAL_BIN}" ${path})
}

function set_manpath() {
    # use nvim with |Man| plugin as pager for man
    export MANPAGER="nvim +Man!"

    LOCAL_MAN="${LOCAL}/share/man"
    # safely append the man-path to npm's packages by preserving MANPATH if already
    # defined, otherwise by "sourcing" it with |$ manpath|
    export MANPATH="${MANPATH-$(manpath)}:${LOCAL_MAN}"
}

function set_ime() {
    export GTK_IM_MODULE="fcitx"
    export QT_IM_MODULE="fcitx"
    export XMODIFIERS=@im="fcitx"
}

function set_gpg() {
    # for shell invocation of gpg
    export GPG_TTY=$(tty)
}

function set_fzf() {
    export FZF_COMPLETION_TRIGGER="jk"

    export FZF_COMPLETION_OPTS="\
        --border=none \
        --prompt='% ' \
        --info=inline:' <<  ' \
    "
}

function main() {
    set_path
    set_manpath
    set_ime
    set_gpg
    set_fzf
}
main

# vim: filetype=zsh foldmethod=marker
