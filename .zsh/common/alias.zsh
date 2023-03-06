# aliases {{{
alias c='clear'
alias q='exit'

# NOTE: unlike with bash, NO extra setup necessary for completion with only 'g'
alias g='git'

alias v='vifm /mnt/x/myData /home/shengdi'


# typing |make| can get really cumbersome if done a couple hundred times a day
alias m='make'


# speed up calling nvim
alias nv="nvim -c Vifm"

# lyx {{{
alias x_lyx="nohup \
    env \
        QT_PLUGIN_PATH=/usr/lib/qt/plugins \
        WAYLAND_DISPLAY='' \
    lyx \
    1>/dev/null 2>&1 &\
"
alias x_lyx_wl="nohup \
    env \
        QT_PLUGIN_PATH=/usr/lib/qt/plugins \
    lyx \
    1>/dev/null 2>&1 &\
"
# }}}
# }}}

# vim: filetype=zsh foldmethod=marker
