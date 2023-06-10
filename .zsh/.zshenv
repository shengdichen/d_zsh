export EDITOR="nvim"

# PATH {{{
PYTHON_PACKAGES="${HOME}/.local/bin"
NPM_PACKAGES="${HOME}/.npm_pack"

# remove duplications
typeset -U path
path=("${PYTHON_PACKAGES}" "${NPM_PACKAGES}" ${path})
# }}}

# MAN {{{
# use nvim with |Man| plugin as pager for man
export MANPAGER="nvim +Man!"

# safely append the man-path to npm's packages by preserving MANPATH if already
# defined, otherwise by "sourcing" it with |$ manpath|
export MANPATH="${MANPATH-$(manpath)}:${NPM_PACKAGES}/share/man"
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
