# fzf {{{
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

bindkey -M vicmd -r "\ec"
bindkey -M viins -r "\ec"
bindkey -M vicmd '^Y' fzf-cd-widget
bindkey -M viins '^Y' fzf-cd-widget
# }}}

# zsh-syntax-highlighting {{{
# requires the package:
#       zsh-syntax-highlighting
#
# NOTE:
#   per instruction in the package's GitHub page:
#       ->  https://github.com/zsh-users/zsh-syntax-highlighting#faq
#   this should be sourced near the end of .zshrc
load_zsh_highlighter () {
    local path_zsh_highlighter=\
/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    [[ -e "$path_zsh_highlighter" ]] && source "$path_zsh_highlighter"
}
load_zsh_highlighter && unfunction load_zsh_highlighter
# }}}

# vim: filetype=zsh foldmethod=marker
