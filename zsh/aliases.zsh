alias s='sudo '
alias se='sudo -e'
alias si='sudo -i'

alias ls='ls -hX --color=auto'
if [[ $(command -v nvim) ]];then
    alias vi='nvim'
    alias vim='nvim'
fi
alias grep='grep --color=auto'
alias cp='cp --reflink=auto'
alias dc='cd'
alias ffmpeg='ffmpeg -hide_banner -loglevel warning -stats'
alias bc='bc -qil'
alias df='lfs'
alias mkdir='mkdir -p -v'
alias top='htop'
alias sxiv='sxiv -a '
alias sx='sxiv -tfq '
alias ex='unar'
alias objdump='objdump -M intel'
alias ip='ip --color --brief'

alias xclip='xclip -selection clipboard '
alias xc='xclip'
alias rsync='rsync --info=progress2 --stats -hP'
alias hexdump='hexyl '
alias hd='hexdump'
alias rg='ranger'
alias ag='\rg' # ripgrep
alias ncdu='gdu'

alias cf='wget -O /dev/null https://speedtest.wtnet.de/files/1000mb.bin'

alias sctl='sudo systemctl'
alias sctlu='systemctl --user'

alias orphans='sudo pacman -Rs $(pacman -Qdtq)'
alias pac='pacman'
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacse='pacman -Ss'

alias pakin='yay -S'
alias pakup='yay -Syu'
alias pakse='yay -Ssa'
