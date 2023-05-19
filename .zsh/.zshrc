# zsh {{{
source ~/.zsh/conf/general.zsh

source ~/.zsh/conf/completion.zsh

source ~/.zsh/conf/visual.zsh

source ~/.zsh/conf/external.zsh
# }}}

for f in ~/.zsh/common/**/*.zsh; do
    source "$f"
done

# vim: filetype=zsh foldmethod=marker
