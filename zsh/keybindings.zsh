bindkey -e # I don't like vim bindings in my terminal

autoload zkbd
source ~/.zkbd/$TERM-$DISPLAY

bindkey '^r' history-incremental-search-backward
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Home]}      ]] && bindkey "${key[Home]}"      beginning-of-line
[[ -n ${key[PageUp]}    ]] && bindkey "${key[PageUp]}"    up-line-or-history
[[ -n ${key[Delete]}    ]] && bindkey "${key[Delete]}"    delete-char
[[ -n ${key[End]}       ]] && bindkey "${key[End]}"       end-of-line
[[ -n ${key[PageDown]}  ]] && bindkey "${key[PageDown]}"  down-line-or-history
[[ -n ${key[Up]}        ]] && bindkey "${key[Up]}"        up-line-or-search
[[ -n ${key[Left]}      ]] && bindkey "${key[Left]}"      backward-char
[[ -n ${key[Down]}      ]] && bindkey "${key[Down]}"      down-line-or-search
[[ -n ${key[Right]}     ]] && bindkey "${key[Right]}"     forward-char

bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word


autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
