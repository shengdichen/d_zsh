# firefox {{{
# default firefox to wayland, would otherwise launch in xwayland
# NOTE:
#       confirm launch in wayland by checking about:support in firefox
# SOURCE:
#       https://wiki.archlinux.org/index.php/Firefox#Wayland
export MOZ_ENABLE_WAYLAND=1
# }}}


# ibus {{{
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
# }}}


# GPG {{{
# for shell invocation of gpg
GPG_TTY=$(tty)
export GPG_TTY
# }}}

# PATH {{{
NPM_PACKAGES="${HOME}/.npm_pack"

# remove duplications
typeset -U path
path=("$NPM_PACKAGES" $path)
# }}}

# MAN {{{
# use nvim with |Man| plugin as pager for man
export MANPAGER='nvim +Man!'

# safely append the man-path to npm's packages by preserving MANPATH if already
# defined, otherwise "source" it with $ manpath
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
# }}}

