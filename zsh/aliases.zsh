alias s='sudo '
alias se='sudo -e'
alias si='sudo -i'

alias ls='eza -s extension --git'
alias latr='eza -lastime --git'
if [[ $(command -v nvim 2> /dev/null) ]];then
    alias vi='nvim'
    alias vim='nvim'
    alias vidir='nvim'
fi
if [[ $(command -v uv 2> /dev/null) ]];then
    alias pip='uv pip'
fi
alias grep='grep --color=auto'
alias cp='cp --reflink=auto'
alias dc='cd'
alias ffmpeg='ffmpeg -hide_banner -loglevel warning -stats'
alias ffprobe='ffprobe -hide_banner'
alias ffprove='ffprobe'
alias bc='bc -qil'
alias df='lfs'
alias mkdir='mkdir -p -v'
alias top='btop'
alias sxiv='sxiv -a '
alias sx='sxiv -tfq '
alias ex='unar'
alias objdump='objdump -M intel'
alias ip='ip --color --brief'
alias fd='fd -u'
alias nh='bandwhich'

alias xclip='xclip -selection clipboard '
alias xc='xclip'
alias rsync='rsync --info=progress2 --stats -hP'
alias hexdump='hexyl '
alias hd='hexdump'
alias rg='yazi'
alias ag='\rg -uu' # ripgrep
alias du='dua'
alias ncdu='dua i'

alias cf='wget -O /dev/null https://speedtest.wtnet.de/files/1000mb.bin'

alias sctl='sudo systemctl'
alias sctlu='systemctl --user'

alias orphans='sudo pacman -Rs $(pacman -Qdtq)'
alias pac='pacman'
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacse='pacman -Ss'
alias paco='pacman -Qoq $(which $*)'

alias pakin='paru -S'
alias pakup='paru -Syu'
alias pakse='paru -Ssa'
