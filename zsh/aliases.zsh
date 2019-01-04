alias s='sudo '
alias se='sudo -e'
alias si='sudo -i'

alias mrm='mpc del $(mpc -f %position% | head -1)'
alias ncmpc='ncmpcpp'

if [[ $(command -v exa) ]];then
    alias ls='exa --git --group --grid --color-scale'
else
    alias ls='ls -h --color=auto'
fi
if [[ $(command -v bat) ]];then
    alias cat='bat'
fi
alias grep='grep --color=auto'
alias cp='cp --reflink=auto'
alias dc='cd'
alias ffmpeg='ffmpeg -hide_banner'
alias bc='bc -qil'
alias df='di -x tmpfs -f sMbuvpT'
alias mkdir='mkdir -p -v'
alias top='htop'
alias sxiv='sxiv -a '
alias sx='sxiv -tfq '
alias ex='unar'
alias udu='udiskie-umount -a'
alias wsk='wineserver -k'
alias objdump='objdump -M intel'
alias ip='ip --color --brief'

alias xclip='xclip -selection clipboard '
alias xc='xclip'
alias rsync='rsync --info=progress2 --stats -hP'
alias hd='hexdump'
alias rg='r'
alias ag='\rg'

alias ffp='firefox -P private -new-instance --class="private" &> /dev/null &'
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

alias pakin='yay -S'
alias pakup='yay -Syu'
alias pakse='yay -Ssa'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
