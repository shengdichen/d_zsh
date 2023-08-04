function __launch() {
    function x_wl() {
        nohup "$@" 1>/dev/null 2>&1 &
    }
    function x() {
        WAYLAND_DISPLAY="" x_wl "$@"
    }
}

function __tmux() {
    alias tstart="\
        tmux\
        -2\
        -f ~/.tmux.conf\
        start-server \; source-file \"\${HOME}/.tmux/startup/default.tmux\"\
    "

    alias tatt="tmux -2 attach-session"
}

function __firefox() {
    alias x_fd_wl="\
        MOZ_ENABLE_WAYLAND=1\
        x_wl firefox-developer-edition -P\
    "
    alias x_fd="\
        MOZ_ENABLE_WAYLAND=0\
        x firefox-developer-edition -P\
    "
}

function __jetbrain() {
    function x_jetbr() {
        # needed if invoked under sway
        _JAVA_AWT_WM_NONREPARENTING=1\
        x_wl "$@"
    }

    alias x_pcm="\
        x_jetbr pycharm\
    "
    alias x_itj="\
        x_jetbr idea\
    "
}

function __misc() {
    # append value for screen color-temp (typically 3700)
    alias x_gamma="x_wl gammastep -O"

    alias x_lyx="\
        QT_PLUGIN_PATH=/usr/lib/qt/plugins\
        x lyx\
    "

    # launch as daemon
    alias x_fctx="x_wl fcitx5 -d"

    # for op'ns requiring keyring, e.g., lock & install
    alias poetry_nokeyring="\
        PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring\
        poetry\
    "
}

function main() {
    __launch
    __tmux
    __firefox
    __jetbrain
    __misc

    unfunction __launch __tmux __firefox __jetbrain __misc
}
main
unfunction main
