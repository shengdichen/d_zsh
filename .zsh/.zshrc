# zsh {{{
# zsh-newuser-install {{{
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt histignoredups
setopt histignorespace

# typing `~' will now cd to ~
setopt autocd

# send out beep/flashes at errors
setopt beep

# use vi keybindings
bindkey -v
# }}}

# completion {{{
# basic completion
autoload -Uz compinit; compinit

setopt extendedglob
setopt globdots  # also match dot-files
setopt nomatch

# menu-like completion
zstyle ':completion:*' menu select

# binds {{{
zmodload zsh/complist
bindkey -M menuselect 'g' beginning-of-history
bindkey -M menuselect 'G' end-of-history

bindkey -M menuselect '0' beginning-of-line
bindkey -M menuselect '$' end-of-line

bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'j' down-line-or-search
bindkey -M menuselect 'k' up-line-or-search
bindkey -M menuselect 'l' forward-char

bindkey -M menuselect '/' history-incremental-search-forward
bindkey -M menuselect '?' history-incremental-search-backward

bindkey -M menuselect '\r' accept-line
bindkey -M menuselect 't' accept-and-hold   # select multiple

bindkey -M menuselect 'u' undo
# }}}

# pip zsh-completion {{{
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
# }}}
# }}}

# visual {{{
# use steady, beam-style cursor
echo -ne '\e[6 q'

# PROMPT, aka, PS* {{{
# common elements:
#   %h OR %!
#       ->  current history event number, i.e., "line number"
#   %?
#       ->  exit code of previous command
#   %S/%s
#       ->  turn on/off standout
#   %F
#       ->  use custom format
#   %(?.<command_if_true>.<command_if_false>)

# NOTE:
# remember to always reset formatting before concluding the prompt; the command
# input would otherwise bear the same formatting

if [ $SHLVL -gt 3 ];
then
    PROMPT='%F{015}%#%F{none} '
else
    PROMPT='%S%F{015}%#%s%F{none} '
fi

RPROMPT='%(?..%S%F{009}%?)%s%F{none}'
# }}}
# }}}

# externals {{{
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
# }}}
# }}}

for f in ~/.zsh/common/**/*.zsh; do
    source "$f"
done

# vim: filetype=zsh foldmethod=marker
