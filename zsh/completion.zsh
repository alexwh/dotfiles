autoload -U compinit
compinit -i
compdef mcd=cd
zmodload -i zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
expand-or-complete-with-dots() {
	echo -n "\e[31m......\e[0m"
	zle expand-or-complete
	zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
