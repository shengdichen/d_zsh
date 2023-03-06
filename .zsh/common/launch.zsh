x() {
    nohup \
        env WAYLAND_DISPLAY='' \
        "$@" \
    1>/dev/null 2>&1 &
}

x_wl() {
    nohup "$@" 1>/dev/null 2>&1 &
}

# tmux-related {{{
# starting the tmux server
alias tstart='\
    tmux \
    -2 \
    -f ~/.tmux.conf \
    start-server \; source-file ~/.tmux/startup/default.tmux\
'

# shortcut for attaching a specific tmux session
alias tatt='tmux -2 attach-session'
# }}}

# env-set'g necessary when invoked under sway
alias x_pcm="nohup \
    env \
        _JAVA_AWT_WM_NONREPARENTING=1 \
    pycharm\
    1>/dev/null 2>&1 &\
"

alias x_kps="nohup \
    env \
        WAYLAND_DISPLAY='' \
    keepassxc \
    1>/dev/null 2>&1 &\
"

# vim: filetype=zsh foldmethod=marker
