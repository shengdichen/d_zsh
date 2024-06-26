function __set_basic() {
    export EDITOR="nvim"
}

function __set_path() {
    local LOCAL="${HOME}/.local"

    local LOCAL_BIN="${LOCAL}/bin"
    export npm_config_prefix="${LOCAL}"  # ./bin auto-appended

    # remove duplications
    typeset -g -U path  # -g for global-scope write
    path=("${LOCAL_BIN}" ${path})
}

function __set_manpager() {
    export MANPAGER="nvim +Man!"
}

function __set_ime() {
    # REF:
    #   https://wiki.archlinux.org/title/Fcitx5#Integration
    export GTK_IM_MODULE="fcitx"
    export QT_IM_MODULE="fcitx"
    export XMODIFIERS=@im="fcitx"
}

function __set_fzf() {
    export FZF_COMPLETION_TRIGGER="jk"

    export FZF_COMPLETION_OPTS="\
        --border=none \
        --prompt='% ' \
        --info=inline:' <<  ' \
    "
}

function __set_theming() {
    export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7,underline"
}

function main() {
    __set_basic
    __set_path
    __set_manpager
    __set_ime
    __set_fzf
    __set_theming

    unfunction __set_basic __set_path __set_manpager __set_ime __set_fzf __set_theming
}
main
unfunction main
