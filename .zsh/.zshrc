# zsh {{{
# zsh-newuser-install {{{
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt histignoredups

# typing `~' will now cd to ~
setopt autocd

# send out beep/flashes at errors
setopt beep

# make the most of auto-completion of zsh
setopt extendedglob

setopt nomatch

# use vi keybindings
bindkey -v
# }}}

# compinstall {{{
zstyle :compinstall filename '$ZDOTDIR/.zshrc'

autoload -Uz compinit
compinit
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
# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

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
# }}}

for f in ~/.zsh/common/**/*.zsh; do
    source "$f"
done

# vim: filetype=zsh foldmethod=marker
