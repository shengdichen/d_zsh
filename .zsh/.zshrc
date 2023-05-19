for f in "${ZDOTDIR}"/conf/**/*.zsh; do
    source "$f"
done

for f in "${ZDOTDIR}"/common/**/*.zsh; do
    source "$f"
done

# vim: filetype=zsh foldmethod=marker
