export BROWSER=firefox
export MOZ_USE_XINPUT2=1
export EDITOR=nvim
export TERMINAL=kitty

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
if command -v go 2>&1 > /dev/null;then
    export GOPATH=$(go env GOPATH)
    export PATH="$PATH:$GOPATH/bin"
fi
export NO_AT_BRIDGE=1
export BAT_THEME="Monokai Extended Origin"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Like default, but without / -- ^W must be useful in paths, like it is in vim, bash, tcsh

export GTK_USE_PORTAL=1
