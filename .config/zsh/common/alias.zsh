function __alias_common() {
    alias c="clear"
    alias q="exit"

    alias fh="free -h"

    # NOTE: unlike bash, NO extra setup necessary for auto-completion
    alias g="git"
    alias gg="lua ${HOME}/.config/git/script/commit.lua"

    alias m="make"
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
}

function __pass() {
    function fpass() {
        local pass_dir="password-store"  # intentionally without leading dot
        local target
        target=$(
            find -L "${HOME}/.${pass_dir}/" -type f | grep -e "\.gpg$" | fzf | \
            sed "s/^.*\.${pass_dir}\/\(.*\).gpg$/\1/" \
        )

        local pw_time=7
        if [[ "${target}" == *.mfa ]]; then
            PASSWORD_STORE_CLIP_TIME="${pw_time}" \
                pass otp code -c "${target}" 1>/dev/null
        else
            echo -n "(s)how, (e)dit, copy (default)? "
            read -r mode
            if [[ "${mode}" == "s" ]]; then
                pass show "${target}" | "${EDITOR}" -R
            elif [[ "${mode}" == "e" ]]; then
                pass edit "${target}" 2>/dev/null
            else
                PASSWORD_STORE_CLIP_TIME="${pw_time}" \
                    pass -c "${target}" 1>/dev/null
            fi
        fi
    }
}

function main() {
    __alias_common
    __alias_man
    __ag_to_fzf_to_editor
    __mail
    __pass

    unfunction __alias_common __alias_man __ag_to_fzf_to_editor __mail __pass
}
main
unfunction main
