for f in ~/.zsh/conf/**/*.zsh; do
    source "$f"
done

for f in ~/.zsh/common/**/*.zsh; do
    source "$f"
done

# vim: filetype=zsh foldmethod=marker
