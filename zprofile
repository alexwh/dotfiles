export BROWSER=firefox
export EDITOR=nvim
export TERMINAL=termite

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
if command -v go 2>&1 > /dev/null;then
    export GOPATH=$(go env GOPATH)
    export PATH="$PATH:$GOPATH/bin"
fi
export NO_AT_BRIDGE=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export BAT_THEME="Monokai Extended Origin"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Like default, but without / -- ^W must be useful in paths, like it is in vim, bash, tcsh
