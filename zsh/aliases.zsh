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
alias cp='cp --reflink=auto'
alias dc='cd'
alias ffmpeg='ffmpeg -hide_banner'
alias c='bc -qil'
alias df='di -x tmpfs'
alias ka='killall -r -i'
alias mkdir='mkdir -p -v'
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
alias cf='wget -O /dev/null cachefly.cachefly.net/100mb.test'
alias tombe='tomb open ~/sync/safe/e -k ~/.tomb/e.key'
alias ovpn='sudo openvpn --cd ~/.openvpn --config client.conf'
alias s3up='aws s3 cp --acl public-read --storage-class REDUCED_REDUNDANCY'

alias sctl='sudo systemctl'
alias sctlu='systemctl --user'

alias ubc='sudo unbound-control'
alias ubcr='sudo unbound-control reload'
alias nh='sudo nethogs'

alias orphans='sudo pacman -Rs $(pacman -Qdtq)'
alias pac='pacman'
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacse='pacman -Ss'

alias pakin='pacaur -S'
alias pakup='pacaur -Syu'
alias pakse='cower -s --sort=votes'

alias -s txt=vim
alias -s php=vim
alias -s html=vim
alias -s css=vim
alias -s lua=vim
alias -s jpg=sx
alias -s png=sx
alias -s gif=sx
alias -s py=python
alias -s sh=bash
alias -s avi=mpv
alias -s mp4=mpv
alias -s flv=mpv
alias -s mkv=mpv
