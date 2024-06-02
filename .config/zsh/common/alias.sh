__base() {
    c() {
        clear && printf "\e[6 q"
    }
    alias q="exit"

    tatt() {
        "${HOME}/.local/script/tmux.sh" run
    }

    cd_vifm() {
        cd "$(vifm --choose-dir -)"
    }
}

__dev() {
    alias fh="free -h"

    # NOTE: unlike bash, NO extra setup necessary for auto-completion
    alias g="git"
    alias gg="lua ${HOME}/.config/git/script/commit.lua"

    alias m="make"

    alias afe="${HOME}/.local/script/fzf.sh"
}

__man() {
    alias man_fr="man -L fr_FR.UTF-8"
    alias man_ru="man -L ru_RU.UTF-8"
    alias man_de="man -L de_DE.UTF-8"
    alias man_es="man -L es_ES.UTF-8"
    alias man_pt="man -L pt_BR.UTF-8"
    alias man_it="man -L it_IT.UTF-8"
    alias man_sv="man -L sv_SV.UTF-8"
    alias man_zh="man -L zh_TW.UTF-8"
}

__mail() {
    local conf_dir="${HOME}/.config/"

    alias fdm_c="fdm -f \"${conf_dir}/fdm/config\""

    alias mbsync_c="mbsync -c \"${conf_dir}/mbsync/config\""
    alias mbsync_all="mbsync_c ALL"

    alias protonbridge="__x protonmail-bridge-core -n"
}

__network() {
    alias ip_public="curl ifconfig.me"

    alias pingme="ping shengdichen.xyz"
}

__misc() {
    alias swayug="sway --unsupported-gpu"

    fpass() {
        "${HOME}/.local/script/fpass.sh" run
    }

    __update_wayland_display() {
        __get() {
            local _str="WAYLAND_DISPLAY="
            systemctl --user show-environment | grep "${_str}" | sed "s/${_str}//"
        }

        printf "wayland-display> before: [%s]\n" "$(__get)"
        systemctl --user import-environment WAYLAND_DISPLAY
        printf "wayland-display> after: [%s]\n" "$(__get)"
        unset -f __get
    }
}

main() {
    __base
    __dev
    __man
    __mail
    __network
    __misc

    unset -f __base __dev __man __mail __network __misc
}
main
unset -f main
