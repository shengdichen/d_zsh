# zsh {{{
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

# zsh-newuser-install {{{
# typing `~' will now cd to ~
setopt autocd

# send out beep/flashes at errors
setopt beep
# }}}

source ~/.zsh/conf/completion.zsh

source ~/.zsh/conf/visual.zsh

source ~/.zsh/conf/external.zsh
# }}}

for f in ~/.zsh/common/**/*.zsh; do
    source "$f"
done

# vim: filetype=zsh foldmethod=marker
