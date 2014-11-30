export BROWSER=firefox
export EDITOR=vim
export TERMINAL=termite

export PATH="$PATH:$HOME/scripts"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk

# export SDL_AUDIODRIVER=alsa # for steam
# export STEAM_FRAME_FORCE_CLOSE=1
# export vblank_mode=0
export WINEARCH=win32 # no disadvantages

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Like default, but without / -- ^W must be useful in paths, like it is in vim, bash, tcsh

if [[ $USER = "alex" ]];then
	eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa)
fi
