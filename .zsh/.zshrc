# Lines configured by zsh-newuser-install
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=1000
SAVEHIST=1000


# typing `~' will now cd to ~
setopt autocd

# send out beep/flashes at errors
setopt beep

# make the most of auto-completion of zsh
setopt extendedglob

setopt nomatch

# use vi keybindings
bindkey -v


# external plug-ins {{{
# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

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


# End of lines configured by zsh-newuser-install



# The following lines were added by compinstall
zstyle :compinstall filename '$ZDOTDIR/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#use {$ x <argv>} to open file in background
x() {
    nohup \
        env WAYLAND_DISPLAY='' \
        "$@" \
    1>/dev/null 2>&1 &
}

x_wl() {
    nohup "$@" 1>/dev/null 2>&1 &
}

# aliases {{{
alias c='clear'
alias q='exit'

# NOTE: unlike with bash, NO extra setup necessary for completion with only 'g'
alias g='git'

# tmux-related {{{
# starting the tmux server
alias tstart='\
    tmux \
    -2 \
    -f ~/.tmux.conf \
    start-server \; source-file ~/.tmux/startup/default.tmux\
'

# shortcut for attaching a specific tmux session
alias tatt='tmux -2 attach-session'
# }}}

alias v='vifm /mnt/x/myData /home/shengdi'


# typing |make| can get really cumbersome if done a couple hundred times a day
alias m='make'


# speed up calling nvim
alias nv="nvim -c Vifm"

# env-set'g necessary when invoked under sway
alias x_pcm="nohup \
    env \
        _JAVA_AWT_WM_NONREPARENTING=1 \
    pycharm\
    1>/dev/null 2>&1 &\
"

alias x_kps="nohup \
    env \
        WAYLAND_DISPLAY='' \
    keepassxc \
    1>/dev/null 2>&1 &\
"

# firefox {{{
# developer edition {{{
alias x_fd="nohup \
    env \
        MOZ_ENABLE_WAYLAND=0 \
    firefox-developer-edition -P \
    1>/dev/null 2>&1 &\
"

alias x_fd_wl="nohup \
    env \
        MOZ_ENABLE_WAYLAND=1 \
    firefox-developer-edition -P \
    1>/dev/null 2>&1 &\
"
# }}}

# vanilla {{{
alias x_ff="nohup \
    env \
        MOZ_ENABLE_WAYLAND=0 \
    firefox -P \
    1>/dev/null 2>&1 &\
"

alias x_ff_wl="nohup \
    env \
        MOZ_ENABLE_WAYLAND=1 \
    firefox -P \
    1>/dev/null 2>&1 &\
"
# }}}
# }}}

# lyx {{{
alias x_lyx="nohup \
    env \
        QT_PLUGIN_PATH=/usr/lib/qt/plugins \
        WAYLAND_DISPLAY='' \
    lyx \
    1>/dev/null 2>&1 &\
"
alias x_lyx_wl="nohup \
    env \
        QT_PLUGIN_PATH=/usr/lib/qt/plugins \
    lyx \
    1>/dev/null 2>&1 &\
"
# }}}
# }}}


# use steady, beam-style cursor
echo -ne '\e[6 q'


# pip {{{
# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
# pip zsh completion end
# }}}


# PROMPT, aka, PS* {{{
#   %S/%s
#       ->  turn on/off standout
#   %F
#       ->  use custom format

# remember to always reset formatting before concluding the prompt; the command
# input would otherwise bear the same formatting



if [ $SHLVL -gt 3 ];
then
    PROMPT='%F{015}%#%F{none} '
else
    PROMPT='%S%F{015}%#%s%F{none} '
fi

#   %?
#       ->  exit code of previous command
#   %(?.<command_if_true>.<command_if_false>)
RPROMPT='%(?..%S%F{009}%?)%s%F{none}'


#   %h OR %!
#       ->  current history event number, i.e., "line number"
#           RPROMPT='%h'
# }}}

