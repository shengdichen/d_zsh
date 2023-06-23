# bind {{{
# use vicmd & viins
bindkey -v

bindkey -M viins 'JJ' vi-cmd-mode
# }}}

# history {{{
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt histignoredups
setopt histignorespace
# }}}

# spare leading |cd|
setopt autocd

# send out beep/flashes at errors
setopt beep

# vim: filetype=zsh foldmethod=marker