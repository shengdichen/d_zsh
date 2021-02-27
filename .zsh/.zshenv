# firefox {{{
# default firefox to wayland, would otherwise launch in xwayland
# NOTE:
#       confirm launch in wayland by checking about:support in firefox
# SOURCE:
#       https://wiki.archlinux.org/index.php/Firefox#Wayland
MOZ_ENABLE_WAYLAND=1
# }}}


# ibus {{{
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
# }}}

