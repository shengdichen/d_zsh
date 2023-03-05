# input-methods {{{
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
# }}}

# GPG {{{
# for shell invocation of gpg
GPG_TTY=$(tty)
export GPG_TTY
# }}}

# PATH {{{
PYTHON_PACKAGES="${HOME}/.local/bin"
NPM_PACKAGES="${HOME}/.npm_pack"

# remove duplications
typeset -U path
path=("$PYTHON_PACKAGES" "$NPM_PACKAGES" $path)
# }}}

# MAN {{{
# use nvim with |Man| plugin as pager for man
export MANPAGER='nvim +Man!'

# safely append the man-path to npm's packages by preserving MANPATH if already
# defined, otherwise "source" it with $ manpath
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
# }}}

# vim: filetype=zsh foldmethod=marker
