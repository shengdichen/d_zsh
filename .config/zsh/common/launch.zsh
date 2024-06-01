function __launch() {
    # REF:
    #   https://stackoverflow.com/questions/19302913/exit-zsh-but-leave-running-jobs-open

    function __x() {
        nohup "${@}" >/dev/null 2>&1 &
        disown
    }
    function __x_11() {
        WAYLAND_DISPLAY="" nohup "${@}" >/dev/null 2>&1 &
        disown
    }
}

function __jetbrain() {
    function x_jetbr() {
        # REF:
        #   https://wiki.archlinux.org/title/Sway#Java_applications
        _JAVA_AWT_WM_NONREPARENTING=1 __x "$@"
    }

    alias x_pcm="\
        x_jetbr pycharm\
    "
    alias x_itj="\
        x_jetbr idea\
    "
}

function __mpd() {
    alias mpc_admin="mpc --host=admin@localhost"
    alias mpc_user="mpc --host=user@localhost"

    function ncmpc_auto() {
        function __op() {
            mpc --host=user@localhost "${@}" >/dev/null
        }

        if ! pgrep mpd >/dev/null 2>&1; then
            mpd
            for cmd in "repeat" "single"; do
                __op "${cmd}"
            done
            # must surround volume-setting with play-toggling to take effect
            __op play
            __op volume 37
            __op pause
        fi
        ncmpc

        unfunction __op
    }
}

function __misc() {
    # append value for screen color-temp (typically 3700)
    alias x_gamma="__x gammastep -O"

    alias x_lyx="\
        QT_PLUGIN_PATH=/usr/lib/qt/plugins\
        __x_11 lyx\
    "

    # launch as daemon
    alias x_fctx="__x fcitx5 -d"

    # for op'ns requiring keyring, e.g., lock & install
    alias poetry_nokeyring="\
        PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring\
        poetry\
    "
}

function main() {
    __launch
    __jetbrain
    __mpd
    __misc

    unfunction __launch __jetbrain __mpd __misc
}
main
unfunction main
