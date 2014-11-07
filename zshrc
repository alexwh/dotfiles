# oh my zsh
# Path to your oh-my-zsh installation.
ZSH=~/.oh-my-zsh

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git tmux pass)

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.histfile
HISTSIZE="1000000"
SAVEHIST="1000000"

fpath=( "$HOME/.zsh" $fpath )

autoload -Uz edit-command-line zmv promptinit
setopt appendhistory sharehistory histignorespace
unsetopt autocd cdablevars
promptinit
prompt pure


alias s='sudo '
alias se='sudo -e'
alias si='sudo -i'

alias m='mpc'
alias mvol='mpc volume'
alias mn='mpc next'
alias mp='mpc toggle'
alias mrm='mpc del $(mpc -f %position% | head -1)'
alias ncmpc='ncmpcpp'

alias ls='ls -h --color=auto'
alias grep='grep --color=auto'
alias mv='mv -i'
alias rm='rm -I'
alias rn='rm -I'
alias cp='cp --reflink=auto'
alias dc='cd'
alias ffmpeg='ffmpeg -hide_banner'
alias c='bc -qil'
alias df='di -x tmpfs'
alias ka='killall -r -i'
alias mkdir='mkdir -p -v'
alias mkt='cd $(mktemp -d)'
alias chown='chown --preserve-root'
alias free='free -mt'
alias top='htop'
alias sxiv='sxiv -a '
alias sx='sxiv -tfq '
alias t='todo.sh'
alias tls='t ls|sort -n'
alias ex='dtrx'
alias udu='udiskie-umount -a'
alias wsk='wineserver -k'

alias xclip='xclip -selection clipboard '
alias xc='xclip'
alias rsync='rsync --info=progress2 --stats -hP'
alias hexdump='hexdump -C '
alias hd='hexdump'
alias rg='ranger'

alias ffp='firefox -P private -new-instance &> /dev/null &'
alias cf='wget -O /dev/null cachefly.cachefly.net/10mb.test'
alias tombe='tomb open ~/sync/safe/e -k ~/.tomb/e.key'
alias ovpn='sudo openvpn --cd ~/.openvpn --config client.conf'

alias sctl='sudo systemctl '
alias sctlu='systemctl --user '

alias ubc='sudo unbound-control'
alias ubcr='sudo unbound-control reload'
alias nh='sudo nethogs'

alias orphans='sudo pacman -Rs $(pacman -Qdtq)'
alias pac='sudo pacman'
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacse='pacman -Ss'

alias pakin='pacaur -S'
alias pakup='pacaur -Syu'
alias pakse='cower -s --sort=votes'


checkip() {
	dig +short myip.opendns.com @resolver1.opendns.com
}

ccc() { # Convert CurenCy
	[[ $# -ge 3 ]] && curl -s "http://www.google.com/finance/converter?a=${1}&from=${2}&to=${3}" | sed '/res/!d;s/<[^>]*>//g' || \
	echo "usage: $0 amount from to"
}

cx () {
	xclip -i < "$1"
}

pss() {
	ps ax | grep $(sed "s/^\(.\)/[\1]/g" <<< "$1")
}

sshp() {
	ps x | grep '[s]sh -D 5123 -f -N'| awk '{print $1}'|xargs -r kill && \
	[[ -n "$1" ]] && ssh -D 5123 -f -N "$1" || echo killed all
}

chpwd() {
	ls
}

[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

[[ -z "$HOSTNAME" ]] && HOSTNAME=$(uname -n)
if [[ $USER = "alex" ]] && [[ "$HOSTNAME" =~ "arch*" ]];then
	eval $(keychain --eval -Q --quiet id_ecdsa)
fi
