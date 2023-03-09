x_wl() {
    nohup "$@" 1>/dev/null 2>&1 &
}
x() {
    WAYLAND_DISPLAY='' x_wl "$@"
}

# tmux-related {{{
# starting the tmux server
alias tstart='\
    tmux\
    -2\
    -f ~/.tmux.conf\
    start-server \; source-file ~/.tmux/startup/default.tmux\
'

# shortcut for attaching a specific tmux session
alias tatt='tmux -2 attach-session'
# }}}

# append value for screen color-temp (typically 3700)
alias x_gamma="x_wl gammastep -O"

alias x_lyx="\
    QT_PLUGIN_PATH=/usr/lib/qt/plugins\
    x lyx\
"

# env-set'g necessary when invoked under sway
alias x_pcm="\
    _JAVA_AWT_WM_NONREPARENTING=1\
    x_wl pycharm\
"

# firefox {{{
alias x_fd_wl="\
    MOZ_ENABLE_WAYLAND=1\
    x_wl firefox-developer-edition -P\
"
alias x_fd="\
    MOZ_ENABLE_WAYLAND=0\
    x firefox-developer-edition -P\
"
# }}}

# vim: filetype=zsh foldmethod=marker
