x_wl() {
    nohup "$@" 1>/dev/null 2>&1 &
}
x() {
    WAYLAND_DISPLAY="" x_wl "$@"
}

# tmux-related {{{
# starting the tmux server
alias tstart="\
    tmux\
    -2\
    -f ~/.tmux.conf\
    start-server \; source-file \"\${HOME}/.tmux/startup/default.tmux\"\
"

# shortcut for attaching a specific tmux session
alias tatt="tmux -2 attach-session"
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
alias x_itj="\
    _JAVA_AWT_WM_NONREPARENTING=1\
    x_wl idea\
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

# launch as daemon
alias x_fctx="x_wl fcitx5 -d"

# for op'ns requiring keyring, e.g., lock & install
alias poetry_nokeyring="\
    PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring\
    poetry\
"

# vim: filetype=zsh foldmethod=marker
