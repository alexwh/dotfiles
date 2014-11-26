export BROWSER=firefox
export EDITOR=vim
export TERMINAL=termite

export PATH="$PATH:/home/alex/scripts"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk
export ZSH_TMUX_AUTOSTART="true"

export SDL_AUDIODRIVER=alsa # for steam
# export STEAM_FRAME_FORCE_CLOSE=1
# export vblank_mode=0
export WINEARCH=win32 # no disadvantages

# messy. does this even do anything?
if [[ $HOSTNAME = "archbox" ]];then
	export LIBVA_DRIVER_NAME=vdpau
	export VDPAU_DRIVER=r600
fi

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Like default, but without / -- ^W must be useful in paths, like it is in vim, bash, tcsh
