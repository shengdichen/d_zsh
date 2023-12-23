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
        tmux -2 \
        start-server \; source-file \"\${HOME}/.config/tmux/script/launch.tmux\"\
    "

    alias tatt="tmux -2 attach-session"
}

function __browser() {
    alias x_qb_wl="\
        x_wl qutebrowser --restore def\
    "
    alias x_fd_wl="\
        MOZ_ENABLE_WAYLAND=1\
        x_wl firefox-developer-edition -P\
    "
    alias x_fd="\
        MOZ_ENABLE_WAYLAND=0\
        x firefox-developer-edition -P\
    "
    alias x_chrom_wl="\
        x_wl chromium \
        --ozone-platform-hint=auto --gtk-version=4\
    "
}

function __jetbrain() {
    function x_jetbr() {
        # REF:
        #   https://wiki.archlinux.org/title/Sway#Java_applications
        _JAVA_AWT_WM_NONREPARENTING=1 x_wl "$@"
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
    __browser
    __jetbrain
    __misc

    unfunction __launch __tmux __browser __jetbrain __misc
}
main
unfunction main
