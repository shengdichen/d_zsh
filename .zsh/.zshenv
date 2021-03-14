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

