# scripts
:D  
pls dont use the file ones without being sure im too lazy to make them fool proof

## wp completions
for zsh
```zsh zsh
_wp() {
    local -a args
    args+=(
        '-l[list wallpaper image names]'
        '-d[show wallpaper directory]'
    )
    # _arguments $args[@] # uncomment this out if you want -l and -d
    _arguments '1: :_files -W $(wp -d)'
}
compdef _wp wp
```
for bash
```bash bash
_wp() {
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if test "$COMP_CWORD" -eq 1; then
        COMPREPLY=($(compgen -W "$(ls $(wp -d))" -- "$cur"))
    fi
    return 0
}
complete -F _wp wp
```
