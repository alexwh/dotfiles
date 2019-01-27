HISTFILE=~/.histfile
HISTSIZE="1000000"
SAVEHIST="1000000"

autoload -Uz zmv
autoload -Uz colors && colors
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
unset zle_bracketed_paste

unsetopt flowcontrol

# for wting/autojump#474
unsetopt bg_nice

setopt inc_append_history
setopt share_history
setopt hist_ignore_space
setopt hist_verify
setopt extended_history
setopt hist_expire_dups_first
setopt prompt_subst
setopt transient_rprompt
setopt menu_complete
setopt complete_in_word
setopt always_to_end
setopt auto_pushd
setopt pushd_ignore_dups
setopt interactive_comments
