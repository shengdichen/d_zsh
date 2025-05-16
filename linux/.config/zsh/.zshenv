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
    # REF:
    #   https://vitormv.github.io/fzf-themes/

    export FZF_DEFAULT_OPTS="$(
        printf "--reverse --height 79%%"

        printf " --color "
        printf "bg:-1,fg:-1,"
        printf "bg+:8,fg+:-1:regular,"
        printf "hl:5,"
        printf "hl+:5:regular"

        printf " --color header:7"
        # printf " --header-first"  # header before prompt

        printf " --color pointer:15:regular"  # current cursor-line
        printf " --pointer \"\""  # hide pointer

        printf " --color marker:7:regular"  # selected in multi
        printf " --marker \"+ \""
        printf " --marker-multi-line \"+| \""

        printf " --color prompt:7:regular"
        printf " --prompt \"> \""
        printf " --color query:-1:regular"  # actual input

        printf " --color "
        printf "spinner:7:regular,"
        printf "info:7"  # counter of matches & (multi-)selections

        printf " --color separator:7"  # line after |info|
        printf " --no-separator"  # hide completely

        printf " --color "
        printf "border:8,"
        printf "gutter:-1,"
        printf "scrollbar:7"
    )"

    export FZF_COMPLETION_TRIGGER="jk"

    export FZF_COMPLETION_OPTS="\
        --prompt='% ' \
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
