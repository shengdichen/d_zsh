for f in "${ZDOTDIR}/conf"/**/*."zsh"; do
    source "${f}"
done

for f in "${ZDOTDIR}/common"/**/*"."*"sh"; do
    source "${f}"
done
