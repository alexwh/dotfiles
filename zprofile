export BROWSER=firefox
export EDITOR=vim
export TERMINAL=termite

export PATH="$PATH:$HOME/bin"
if command -v go 2>&1 > /dev/null;then
    export GOPATH=$(go env GOPATH)
    export PATH="$PATH:$GOPATH/bin"
fi
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk
export WINEARCH=win32 # no disadvantages
export NO_AT_BRIDGE=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export BAT_THEME="Monokai Extended Origin"

export FZF_TMUX=1
export FZF_TMUX_HEIGHT="35%"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
export FZF_DEFAULT_OPTIONS="--reverse"

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Like default, but without / -- ^W must be useful in paths, like it is in vim, bash, tcsh
