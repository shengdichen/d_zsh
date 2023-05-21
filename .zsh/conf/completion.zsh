# basic completion
autoload -Uz compinit; compinit

setopt extendedglob
setopt globdots  # also match dot-files
setopt nomatch

# menu {{{
# enable menu-like completion
zstyle ':completion:*' menu select

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

# vim: filetype=zsh foldmethod=marker
