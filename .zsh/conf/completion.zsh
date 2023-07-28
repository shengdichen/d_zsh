function __basic() {
    autoload -Uz compinit; compinit

    setopt extendedglob
    setopt globdots  # also match dot-files
    setopt nomatch
}

function __menu_like() {
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
}

function __complete_pip() {
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="${words}[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 ${words}[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
}

# NOTE:
#   1. generated with:
#   $ npm completion
function __complete_npm() {
if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
}

function main() {
    __basic
    __menu_like
    __complete_pip
    __complete_npm

    unfunction __basic __menu_like __complete_pip __complete_npm
}
main
unfunction main

# vim: filetype=zsh
