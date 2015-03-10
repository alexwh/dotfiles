autoload -Uz compinit && compinit
zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors '' # use ls colors
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

compdef -d mpv
