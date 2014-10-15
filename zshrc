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
#PS1='%(?..[%?] )%#%~> ' # evals to "~>" if exit code = 0 and "[X] ~>" if >1

fpath=( "$HOME/.zsh" $fpath )

autoload -Uz edit-command-line zmv promptinit
setopt appendhistory sharehistory histignorespace
unsetopt autocd cdablevars
promptinit
prompt pure


alias vi='vim'
alias se='sudo -e'
alias s='sudo '
alias si='sudo -i'

alias m='mpc'
alias mvol='mpc volume'
alias mn='mpc next'
alias mp='mpc toggle'
alias ms='mpc stop'
alias mcp='mpc'
alias mrm='mpc del $(mpc -f %position% | head -1)'
alias ncmpc='ncmpcpp'

alias ls='ls -h --color=auto'
alias grep='grep --color=auto'
alias mv='mv -i'
alias rm='rm -I'
alias rn='rm -I'
alias cp='cp -r --reflink=auto'
alias dc='cd'
alias ffmpeg='ffmpeg -hide_banner'
alias c='bc -qil'
alias 'ps?'='ps ax | grep $(sed "s/^\(.\)/[\1]/g" <<< $1)'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]' <<< "
alias df='di -x tmpfs'
alias ka='killall -r -i'
alias mkdir='mkdir -p -v'
alias shred='shred -fuz'
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

alias pac='sudo pacman'
alias pacup='sudo pacman -Syu'
alias pacin='pacaur -S'
alias pacrm='sudo pacman -Rns'
alias pacse='pacman -Ss'

alias pakin='pacaur -S'
alias pakup='pacaur -Syu'
alias pakse='cower -s --sort=votes'


orphans() {
	[[ ! -n $(pacman -Qdt) ]] && echo no orphans to remove || sudo pacman -Rs $(pacman -Qdtq)
}

checkip() {
	dig +short myip.opendns.com @resolver1.opendns.com
}

checkdns() {
	dig +short whoami.akamai.net
}

db () {
	dropbox puburl $1 | perl -ne "chomp and print" | xclip -i -selection clipboard
}

ccc() { # Convert CurenCy
	[[ -n "$1" && -n "$2" && -n "$3" ]] && curl -s "http://www.google.com/finance/converter?a=$1&from=$2&to=$3" | sed '/res/!d;s/<[^>]*>//g' || \
	echo "usage: $0 amount from to"
}

wgetm() {
	[[ -n "$1" ]] && wget -E -H -k -p -nd "$1"
}

cx () {
	xclip -i < "$1"
}

getstdout() {
	strace -ff -e trace=write -e write=1,2 -p $(pidof "$1")
}

sshp() {
	ps x | grep '[s]sh -D 5123 -f -N'| awk '{print $1}'|xargs -r kill && \
	[[ -n "$1" ]] && ssh -D 5123 -f -N "$1" || echo killed all
}

chpwd() {
	ls
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

[[ -z "$HOSTNAME" ]] && HOSTNAME=$(uname -n)
if [[ $USER = "alex" ]] && [[ "$HOSTNAME" =~ "arch*" ]];then
	eval $(keychain --eval -Q --quiet id_ecdsa)
fi
