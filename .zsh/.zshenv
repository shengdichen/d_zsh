export EDITOR="nvim"

# PATH {{{
LOCAL="${HOME}/.local"

LOCAL_BIN="${LOCAL}/bin"
export npm_config_prefix="${LOCAL}"  # ./bin auto-appended

# remove duplications
typeset -U path
path=("${LOCAL_BIN}" ${path})
# }}}

# MAN {{{
# use nvim with |Man| plugin as pager for man
export MANPAGER="nvim +Man!"

LOCAL_MAN="${LOCAL}/share/man"
# safely append the man-path to npm's packages by preserving MANPATH if already
# defined, otherwise by "sourcing" it with |$ manpath|
export MANPATH="${MANPATH-$(manpath)}:${LOCAL_MAN}"
# }}}

export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export XMODIFIERS=@im="fcitx"

# for shell invocation of gpg
export GPG_TTY=$(tty)

# fzf {{{
export FZF_COMPLETION_TRIGGER="jk"

export FZF_COMPLETION_OPTS="\
    --border=none \
    --prompt='% ' \
    --info=inline:' <<  ' \
"
# }}}

# vim: filetype=zsh foldmethod=marker
