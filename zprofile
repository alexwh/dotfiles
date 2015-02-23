export BROWSER=firefox
export EDITOR=vim
export TERMINAL=termite

export PATH="$PATH:$HOME/scripts"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk
export WINEARCH=win32 # no disadvantages
# x11-ssh-askpass sucks
export SSH_ASKPASS=

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Like default, but without / -- ^W must be useful in paths, like it is in vim, bash, tcsh
