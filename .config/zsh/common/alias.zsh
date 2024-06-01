function __alias_common() {
    # restore cursor-shape with nvim
    alias c="${EDITOR} -c q && clear"
    alias q="exit"

    alias fh="free -h"

    # NOTE: unlike bash, NO extra setup necessary for auto-completion
    alias g="git"
    alias gg="lua ${HOME}/.config/git/script/commit.lua"

    alias m="make"

    alias swayug="sway --unsupported-gpu"
}

function __alias_man() {
    alias man_fr="man -L fr_FR.UTF-8"
    alias man_ru="man -L ru_RU.UTF-8"
    alias man_de="man -L de_DE.UTF-8"
    alias man_es="man -L es_ES.UTF-8"
    alias man_pt="man -L pt_BR.UTF-8"
    alias man_it="man -L it_IT.UTF-8"
    alias man_sv="man -L sv_SV.UTF-8"
    alias man_zh="man -L zh_TW.UTF-8"
}

function __ag_to_fzf_to_editor() {
    alias afe="\
        ag \
            --line-numbers --noheading \
            --hidden \
            . \
        | \
        fzf \
        | \
        awk \
            -F : \
            '{cmd=\"\$EDITOR +\"\$2\" -- \"\$1; system(cmd)}' \
    "
}

function __mail() {
    local conf_dir="${HOME}/.config/"

    alias fdm_c="fdm -f \"${conf_dir}/fdm/config\""

    alias mbsync_c="mbsync -c \"${conf_dir}/mbsync/config\""
    alias mbsync_all="mbsync_c ALL"

    alias prontonbridge="__x protonmail-bridge-core -n"
}

function __pass() {
    source "${HOME}/.local/script/fpass.sh"
}

__cd_vifm() {
    cd_vifm () {
        cd "$(vifm --choose-dir -)"
    }
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

function __network() {
    alias ip_public="curl ifconfig.me"

    alias pingme="ping shengdichen.xyz"
}

function main() {
    __alias_common
    __alias_man
    __ag_to_fzf_to_editor
    __cd_vifm
    __mail
    __pass
    __network

    unfunction __alias_common __alias_man __ag_to_fzf_to_editor __cd_vifm __mail __pass __network
}
main
unfunction main
