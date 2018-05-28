export BROWSER=firefox
export EDITOR=vim
export TERMINAL=termite

export PATH="$PATH:$HOME/bin"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk
export WINEARCH=win32 # no disadvantages
export NO_AT_BRIDGE=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT="35%"
export FZF_DEFAULT_COMMAND='fd --type f'

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Like default, but without / -- ^W must be useful in paths, like it is in vim, bash, tcsh
