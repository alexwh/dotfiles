fpath=(~/.zsh $fpath)
HISTFILE=~/.histfile
HISTSIZE="1000000"
SAVEHIST="1000000"

autoload -U edit-command-line zmv
setopt appendhistory sharehistory histignorespace
unsetopt autocd cdablevars
