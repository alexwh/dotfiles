HISTFILE=~/.histfile
HISTSIZE="1000000"
SAVEHIST="1000000"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=200

autoload -Uz zmv
autoload -Uz colors && colors
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

unsetopt flowcontrol
unsetopt nomatch

# for wting/autojump#474
unsetopt bg_nice

setopt share_history
setopt hist_ignore_space
setopt hist_verify
setopt extended_history
setopt prompt_subst
setopt transient_rprompt
setopt menu_complete
setopt complete_in_word
setopt always_to_end
setopt auto_pushd
setopt pushd_ignore_dups
setopt interactive_comments
